# frozen_string_literal: true

# Converts the guide as fetched (the upstream branch: pages/*.textile,
# images/, manifest.json) to Markdown: en/<section>/<slug>.md with front
# matter, images/, index.yml (the sections) and topics.yml (topic -> page).
# guide.yml gives the sections and the slugs of the listed pages.
#
#   ruby convert.rb <upstream directory> <output directory>
require 'json'
require 'yaml'
require 'fileutils'
require 'open3'
require 'pathname'
require_relative 'textile'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

UPSTREAM, OUT = ARGV
abort 'usage: convert.rb <upstream> <out>' unless UPSTREAM && OUT

WIKI_URL = 'https://www.redmine.org/projects/redmine/wiki/'
ISSUE_URL = 'https://www.redmine.org/issues/'
# The guide's index pages; index.yml replaces them.
INDEX_PAGES = %w[Guide Installation_Guide Administrator_Guide User_Guide Developer_Guide].freeze

manifest = JSON.parse(File.read(File.join(UPSTREAM, 'manifest.json')))
pages = manifest['pages']
config = YAML.safe_load_file(File.join(OUT, 'guide.yml'))

def slug(title)
  title.sub(/\ARedmine(?=[A-Z])/, '')
       .gsub(/([a-z\d])([A-Z])/, '\1-\2').gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
       .downcase.gsub(/[^a-z0-9]+/, '-').gsub(/\A-|-\z/, '')
end

# Redmine's heading anchor (ApplicationHelper#sanitize_anchor_name).
def anchor(text)
  text.to_s.gsub(/[^\s\-\p{Word}]/, '').gsub(/\s+(-+\s*)?/, '-')
end

# Topic of every page: listed pages from guide.yml, the others under the
# section of the page that links them (or of their wiki parent).
topics = {}
section_of = {}
config['sections'].each do |section|
  section['topics'].each do |page, name|
    next unless pages.key?(page)

    topics[page] = "#{section['id']}/#{name}"
    section_of[page] = section['id']
  end
end
pending = pages.keys - INDEX_PAGES - topics.keys
4.times do
  pending.dup.each do |page|
    from = [pages[page]['parent'], pages[page]['linked_from']].find { |p| section_of[p] }
    next unless from

    section_of[page] = section_of[from]
    topics[page] = "#{section_of[page]}/#{slug(page)}"
    pending.delete(page)
  end
end
pending.each { |page| warn "no section, skipped: #{page}" }
taken = {}
topics.each do |page, topic|
  if taken[topic]
    topics[page] = "#{topic}-#{slug(page)}"
    warn "slug taken, #{page} is #{topics[page]}"
  end
  taken[topics[page]] = true
end
by_lower = topics.keys.to_h { |page| [page.downcase, page] }

# The guide's own names for its pages, from the links of its index pages
# ([[RedmineAccounts|User accounts]]): the title of a page without a heading.
labels = {}
INDEX_PAGES.each do |index_page|
  file = File.join(UPSTREAM, 'pages', "#{index_page}.textile")
  next unless File.exist?(file)

  File.read(file, encoding: 'UTF-8').scan(/\[\[([^\]|#]+)(?:#[^\]|]*)?\|([^\]]+)\]\]/) do |page, label|
    labels[page.strip.tr(' ', '_')] ||= label.strip
  end
end

# The screenshot bin/screenshots takes in place of an old image.
def retake(lang, page, file)
  "images/#{lang}/#{page}/#{file.sub(/(@2x)?\.\w+\z/, '')}@2x.png"
end

def relative(from_topic, to_topic)
  Pathname(to_topic).relative_path_from(Pathname(File.dirname(from_topic))).to_s
end

# The target of a [[wiki link]]: the topic, or the page on redmine.org.
def wiki_href(from_topic, target, topics, by_lower)
  page, hash = target.split('#', 2)
  page = page.strip.tr(' ', '_')
  real = by_lower[page.downcase]
  fragment = hash ? "##{anchor(hash)}" : ''
  if page.empty?
    fragment
  elsif real
    "#{relative(from_topic, topics[real])}.md#{fragment}"
  else
    "#{WIKI_URL}#{page}#{fragment}"
  end
end

# Turns a [[wiki link]] into a Markdown link (or an HTML one, in a table the
# converter writes as HTML). A link to another project's wiki keeps its text.
def wiki_link(from_topic, target, label, topics, by_lower, html: false)
  label = (label || target).strip
  return label if target.include?(':') && !target.start_with?('#')

  href = wiki_href(from_topic, target, topics, by_lower)
  html ? %(<a href="#{CGI.escapeHTML(href)}">#{label}</a>) : "[#{label}](#{href})"
end

def child_pages(title, pages)
  pages.select { |_, page| page['parent'] == title }.keys.sort.map { |child| "* [[#{child}]]" }.join("\n")
end

# Redmine's old PNG icons: dropped when a label (*Label* or text in a list)
# follows, otherwise replaced from guide.yml's icons.
def replace_icons(text, page, icons)
  text.gsub(%r{!(?:https?://www\.redmine\.org)?/images/([\w.-]+)!(-icon)?(\s*)}) do
    icon, suffix, space = Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3)
    following = Regexp.last_match.post_match
    label = icons.dig(page, icon) || icons.dig('*', icon)
    if label && !following.start_with?('*')
      "#{label}#{suffix ? ' icon' : ''}#{space}"
    else
      ''
    end
  end
end

# #123 and issue #123 outside code become links to redmine.org's issues
# (also when pandoc escaped the # as \#), but not another site's ("bugs.ruby-lang.org #21856").
ISSUE_REF = /(?<![\w&\/\[(#\\])(?<!\.org )\\?#(\d{2,6})\b/

def link_issues(markdown)
  fence = false
  markdown.lines.map do |line|
    fence = !fence if line.start_with?('```')
    next line if fence

    line.split(/(`[^`]*`|<[^<>\n]+>)/).map do |part|
      part.start_with?('`', '<') ? part : part.gsub(ISSUE_REF) { "[##{Regexp.last_match(1)}](#{ISSUE_URL}#{Regexp.last_match(1)})" }
    end.join
  end.join
end

# The same in the HTML of a table, outside tags and <code>.
def link_issues_html(html)
  code = false
  html.split(/(<[^>]+>)/).map do |part|
    if part.start_with?('<')
      code = true if part.match?(/\A<code\b/)
      code = false if part == '</code>'
      part
    else
      code ? part : part.gsub(ISSUE_REF) { %(<a href="#{ISSUE_URL}#{Regexp.last_match(1)}">##{Regexp.last_match(1)}</a>) }
    end
  end.join
end

FileUtils.rm_rf(Dir[File.join(OUT, 'en', '*')])
# The screenshots retaken in Redmine 7.0.3 (bin/screenshots, images/<lang>/)
# stay.
Dir[File.join(OUT, 'images', '*')].each { |dir| FileUtils.rm_rf(dir) unless File.basename(dir).match?(/\A[a-z]{2}\z/) }
topics.each do |page, topic|
  text = File.read(File.join(UPSTREAM, 'pages', "#{page}.textile"), encoding: 'UTF-8')
  links = []
  held = Textile::Held.new
  images = Array(pages[page]['images'])
  # The image's path in the guide, or nil when the image was not fetched.
  image_path = lambda do |src|
    file = File.basename(src)
    if File.exist?(File.join(OUT, retake('en', page, file)))
      relative(topic, "../#{retake('en', page, file)}")
    elsif images.include?(file)
      relative(topic, "../images/#{page}/#{file}")
    end
  end
  literals = Textile::Literals.new
  text = Textile.extract_pre(text, held)
  text = Textile.notextile(text, literals)
  text = replace_icons(text, page, config['icons'] || {})
  text = text.gsub(/\{\{\s*[<>]?toc\s*\}\}\n?/i, '')
             .gsub(/\{\{child_pages[^}]*\}\}/) { child_pages(page, pages) }
             .gsub(/\{\{include\(([^)]+)\)\}\}/) { "[[#{Regexp.last_match(1)}]]" }
             .gsub(/!\{[^}]*\}\.?/, '!').gsub(/![<>=]+/, '!')
             .gsub(/^p[<>=]+\.\s+/, '')
             .gsub(/\[\[([^\]|]+)(?:\|([^\]]*))?\]\]/) do
               links << [Regexp.last_match(1), Regexp.last_match(2)]
               "RGLINKx#{links.size - 1}x"
             end
  text = Textile.unescape_links(text)
  text = Textile.styled_spans(Textile.escape_html_tags(text))
  text = Textile.mark_footnotes(text)
  text = Textile.tables(text, held) do |html|
    html = html.gsub(/RGLINKx(\d+)x/) do
      target, label = links[Regexp.last_match(1).to_i]
      wiki_link(topic, target, label, topics, by_lower, html: true)
    end
    html = html.gsub(/<img src="([^"]+)"([^>]*)>/) do
      path = image_path.call(Regexp.last_match(1))
      path ? %(<img src="#{path}"#{Regexp.last_match(2)}>) : ''
    end
    html = html.gsub(%r{href="(/(?!/)[^"]*)"}) { %(href="https://www.redmine.org#{Regexp.last_match(1)}") }
    held.html(literals.html(Textile.restore_hashes(Textile.footnotes(link_issues_html(html)))))
  end
  text = Textile.collapse(text, held)
  text = Textile.normalize_lists(text)
  markdown, status = Open3.capture2('pandoc', '-f', 'textile', '-t', 'gfm', '--wrap=none', stdin_data: text)
  abort "pandoc failed on #{page}" unless status.success?

  markdown = markdown.force_encoding(Encoding::UTF_8)

  markdown = markdown.gsub(/RGLINKx(\d+)x/) do
    target, label = links[Regexp.last_match(1).to_i]
    wiki_link(topic, target, label, topics, by_lower)
  end
  markdown = markdown.gsub(/!\[([^\]]*)\]\(([^)\s]+)\)/) do
    alt = Regexp.last_match(1)
    path = image_path.call(Regexp.last_match(2))
    if path
      "![#{alt}](#{path})"
    else
      alt.empty? ? '' : "*#{alt}*"
    end
  end
  # Links to other parts of redmine.org (/projects/..., /releases/...).
  markdown = markdown.gsub(%r{\]\((/(?!/)[^)\s]*)\)}) { "](https://www.redmine.org#{Regexp.last_match(1)})" }
  markdown = literals.markdown(Textile.restore_hashes(Textile.footnotes(link_issues(markdown))))
  # The blocks kept out of pandoc come back after the issue links: code is
  # shown as it is.
  markdown = held.restore(markdown.gsub(/\n{3,}/, "\n\n").gsub(/\(\s+\)/, ''))
  unless markdown.lstrip.start_with?('# ')
    markdown = markdown.sub(/\A\s*##\s+/, '# ') if markdown.lstrip.start_with?('## ')
    markdown = "# #{labels[page] || page.tr('_', ' ')}\n\n#{markdown}" unless markdown.lstrip.start_with?('# ')
  end
  info = pages[page]
  front = {
    'source' => page,
    'source_url' => info['url'],
    'source_version' => info['version'],
    'source_updated_on' => info['updated_on'],
  }
  path = File.join(OUT, 'en', "#{topic}.md")
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, "#{front.to_yaml}---\n\n#{markdown.strip}\n")
  next if images.empty?

  FileUtils.mkdir_p(File.join(OUT, 'images', page))
  images.each do |file|
    next if File.exist?(File.join(OUT, retake('en', page, file)))

    FileUtils.cp(File.join(UPSTREAM, 'images', page, file), File.join(OUT, 'images', page, file))
  end
end

# The page titles of each language (glossary/<lang>.pages.yml), shown in the
# sidebar while a page is not translated yet.
page_titles = Dir.glob(File.join(OUT, 'glossary', '*.pages.yml')).sort.to_h do |file|
  [File.basename(file, '.pages.yml'), YAML.safe_load_file(file)['pages'] || {}]
end

index = {
  'sections' => config['sections'].map do |section|
    listed = section['topics'].keys.filter_map do |page|
      topic = topics[page]
      next unless topic

      title = {}
      title['en'] = labels[page] if labels[page]
      page_titles.each { |lang, titles| title[lang] = titles.dig(topic, lang) if titles.dig(topic, lang) }
      title.empty? ? topic : { 'id' => topic, 'title' => title }
    end
    { 'id' => section['id'], 'title' => section['title'], 'topics' => listed }
  end,
}
# The translations show the screenshots retaken in their language.
Dir.children(OUT).select { |dir| dir.match?(/\A[a-z]{2}\z/) && dir != 'en' }.each do |lang|
  Dir.glob('**/*.md', base: File.join(OUT, lang)).each do |file|
    path = File.join(OUT, lang, file)
    text = File.read(path)
    switched = text.gsub(%r{\]\(((?:\.\./)+)images/([^/)\s]+)/([^/)\s]+)\)}) do
      prefix, page, image = Regexp.last_match.captures
      retaken = retake(lang, page, image)
      !page.match?(/\A[a-z]{2}\z/) && File.exist?(File.join(OUT, retaken)) ? "](#{prefix}#{retaken})" : Regexp.last_match(0)
    end
    File.write(path, switched) unless switched == text
  end
end

header = "# Generated by bin/convert from guide.yml. Do not edit.\n"
File.write(File.join(OUT, 'index.yml'), header + index.to_yaml.sub(/\A---\n/, ''))
File.write(File.join(OUT, 'topics.yml'), header + topics.sort_by(&:last).to_h.invert.to_yaml.sub(/\A---\n/, ''))
warn "#{topics.size} topics"
