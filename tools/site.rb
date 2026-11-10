# frozen_string_literal: true

# Adds the guide to the docs of the website (https://redmine-kit.github.io/redmine-guide/),
# which docs-skeleton builds from docs/. The Docs workflow runs it on the
# checkout's docs/ before the build:
#
#   ruby tools/site.rb docs
#
# - The guide's pages: en/<section>/<topic>.md at <section>/<topic>, and the
#   translations at ja/<section>/<topic>. A page that is not translated shows
#   the English page in the Japanese site, with its Japanese title in the
#   sidebar and the note 「言語: English」, as Redmine Help shows it.
# - Headings get Redmine's anchors (links between pages use them), in lower
#   case as the site's links are (VitePress slugifies a link's anchor); a
#   translation's headings get the English page's anchors, one for one.
# - Each page ends with its source on redmine.org, the copyright, what this
#   project changed and the license of the changes (README.md, "License").
# - The images the pages show, in public/images/.
# - The top pages list the guide's sections (index.yml); docs/README.md
#   becomes about.md.
# - sidebar.json: the sections and their topics in index.yml's order and
#   titles (Japanese: glossary/ja.pages.yml), with the pages index.yml does
#   not list under the page that links them.
#
# Runs with the Ruby of the GitHub runner, without gems.

require 'fileutils'
require 'json'
require 'yaml'

ROOT = File.expand_path('..', __dir__)
LANGUAGES = %w[en ja].freeze
REDMINE = '7.0.3'
# The license of this project's translations, updates and screenshots; the
# text from redmine.org states none (README.md, "License").
LICENSE_URL = { 'en' => 'https://creativecommons.org/licenses/by-sa/4.0/',
                'ja' => 'https://creativecommons.org/licenses/by-sa/4.0/deed.ja' }.freeze
ORG_URL = { 'en' => 'https://redmine-kit.github.io/', 'ja' => 'https://redmine-kit.github.io/ja/' }.freeze
COPYRIGHT = '© Jean-Philippe Lang and the Redmine contributors'

out = ARGV[0] or abort 'Usage: ruby tools/site.rb DOCS_DIR'
out = File.expand_path(out)
abort "#{out}/about.md exists: run on a fresh copy of docs/" if File.exist?(File.join(out, 'about.md'))

def read_yaml(path)
  YAML.safe_load(File.read(File.join(ROOT, path), encoding: 'UTF-8'))
end

def front_matter(text)
  match = text.match(/\A---\n(.*?)\n---\n/m)
  match ? [YAML.safe_load(match[1]) || {}, match.post_match] : [{}, text]
end

# The lines of a page outside fenced code blocks, as [line, index].
def outside_code(lines)
  fence = nil
  lines.each_with_index.select do |line, _|
    if fence
      fence = nil if line.strip.start_with?(fence) && line.strip.delete(fence[0]).empty?
      false
    elsif (marker = line[/\A\s*(`{3,}|~{3,})/, 1])
      fence = marker
      false
    else
      true
    end
  end
end

HEADING = /\A(#+)[ \t]+(.+?)[ \t]*\z/.freeze

# The headings' anchors in order, as Redmine makes them (redmine_help's
# Topic#anchors, after ApplicationHelper#sanitize_anchor_name).
def anchors(headings)
  seen = Hash.new(0)
  headings.map do |heading|
    plain = heading.gsub(/!?\[([^\]]*)\]\([^)]*\)/, '\\1').delete('`*')
    anchor = plain.gsub(/[^\s\-\p{Word}]/, '').gsub(/\s+(-+\s*)?/, '-')
    seen[anchor] += 1
    seen[anchor] > 1 ? "#{anchor}-#{seen[anchor]}" : anchor
  end
end

def heading_lines(body)
  lines = body.split("\n", -1)
  found = outside_code(lines).select { |line, _| line.match?(HEADING) }
  [lines, found.map { |line, index| [index, line.match(HEADING)[2].sub(/[ \t]+#+\z/, '')] }]
end

# The page with `{#anchor}` on each heading.
def with_anchors(body, ids)
  lines, headings = heading_lines(body)
  headings.zip(ids).each do |(index, text), id|
    next if id.nil? || id.empty?

    level = lines[index][/\A#+/]
    lines[index] = "#{level} #{text} {##{id.downcase}}"
  end
  lines.join("\n")
end

# Images (and links to images) point at public/images/.
def with_images(body, images)
  lines = body.split("\n", -1)
  outside_code(lines).each do |line, index|
    lines[index] = line.gsub(%r{(\]\(|src=")\.\./\.\./images/([^)"\s]+)}) do
      images << Regexp.last_match(2)
      "#{Regexp.last_match(1)}/images/#{Regexp.last_match(2)}"
    end
  end
  lines.join("\n")
end

def topic_ids
  Dir.glob('en/**/*.md', base: ROOT).sort.map { |path| path.sub(%r{\Aen/}, '').sub(/\.md\z/, '') }
end

def h1(body)
  body[/^# +(.+)$/, 1].to_s.strip
end

# The source, the copyright, the license and the changes, at the end of a page.
def attribution(lang, page, translated, screenshots)
  source = "[#{page[:source]}](#{page[:source_url]})"
  kit = "[Redmine Kit](#{ORG_URL[lang]})"
  license = "[CC BY-SA 4.0](#{LICENSE_URL[lang]})"
  updated = page[:updated_for]
  lines =
    if lang == 'en'
      changes = ['converted it to Markdown']
      changes << "updated it for Redmine #{updated}" if updated
      changes << (updated ? 'retook its screenshots' : "retook its screenshots in Redmine #{REDMINE}") if screenshots
      ours = [('updates' if updated), ('screenshots' if screenshots)].compact
      ["Source: #{source} on redmine.org, #{COPYRIGHT}, no license stated ([License](../about.md#license)). " \
       "#{kit}, an unofficial project for Redmine, #{sentence(changes)}." +
       (ours.empty? ? '' : " #{sentence(ours).capitalize}: #{license}.")]
    else
      changes = ['Markdown に変換し']
      changes << "Redmine #{updated} に合わせて更新し" if updated
      changes << (updated ? 'スクリーンショットを撮り直し' : "Redmine #{REDMINE} でスクリーンショットを撮り直し") if screenshots
      changes << '日本語に翻訳し' if translated
      ours = [('翻訳' if translated), ('更新' if updated), ('スクリーンショット' if screenshots)].compact
      note = translated ? [] : ['言語: English']
      note + ["原文: redmine.org の #{source}、#{COPYRIGHT}、ライセンスの表示なし ([ライセンス](../about.md#license))。" \
              "Redmine の非公式のプロジェクト #{kit} が、#{changes.join('、')}ました。" +
              (ours.empty? ? '' : "#{ours.join('、')}: #{license}")]
    end
  ['<div data-pagefind-ignore>', '', '---', '', *lines.flat_map { |line| ["<small>#{line}</small>", ''] }, '</div>'].join("\n")
end

def sentence(items)
  items.size > 1 ? "#{items[0...-1].join(', ')} and #{items.last}" : items.first
end

index = read_yaml('index.yml')
sources = read_yaml('topics.yml')
ja_titles = read_yaml('glossary/ja.pages.yml')['pages']
images = []
pages = {}
# English titles: the guide's table of contents (index.yml) where it names
# the topic with a title, else the page's H1.
index_titles = index['sections'].flat_map { |section| section['topics'] }.select { |topic| topic.is_a?(Hash) }
                               .map { |topic| [topic['id'], topic.dig('title', 'en')] }.to_h
                               .select { |_, title| title.to_s.match?(/\A[A-Z]/) }

topic_ids.each do |id|
  meta, en_body = front_matter(File.read(File.join(ROOT, 'en', "#{id}.md"), encoding: 'UTF-8'))
  source = meta['source'] || sources[id]
  page = {
    source: source,
    source_url: meta['source_url'] || "https://www.redmine.org/projects/redmine/wiki/#{source}",
    updated_for: meta['updated_for'],
    titles: { 'en' => index_titles[id] || h1(en_body) },
  }
  _, en_headings = heading_lines(en_body)
  en_ids = anchors(en_headings.map(&:last))

  LANGUAGES.each do |lang|
    file = File.join(ROOT, lang, "#{id}.md")
    translated = lang == 'en' || File.exist?(file)
    body = translated ? front_matter(File.read(file, encoding: 'UTF-8'))[1] : en_body
    ids = en_ids
    if lang != 'en' && translated
      page[:titles][lang] = h1(body)
      _, headings = heading_lines(body)
      if headings.size != en_headings.size
        warn "#{lang}/#{id}.md: #{headings.size} headings, the English page has #{en_headings.size}"
        ids = anchors(headings.map(&:last))
      end
    end
    page[:titles][lang] ||= ja_titles.dig(id, lang) || page[:titles]['en']

    shown = []
    text = with_images(with_anchors(body, ids), shown)
    images.concat(shown)
    screenshots = shown.any? { |image| image.start_with?(*LANGUAGES.map { |l| "#{l}/" }) }
    target = File.join(out, lang == 'en' ? '' : lang, "#{id}.md")
    FileUtils.mkdir_p(File.dirname(target))
    File.write(target, "---\neditLink: false\n---\n#{text.rstrip}\n\n#{attribution(lang, page, translated, screenshots)}\n")
  end
  page[:links] = en_body.scan(/\]\(([^)\s#]+\.md)(?:#[^)\s]*)?\)/).flatten.map do |link|
    File.expand_path(link, "/#{File.dirname(id)}").delete_prefix('/').sub(/\.md\z/, '')
  end
  pages[id] = page
end

images.uniq.each do |image|
  path = image.gsub(/%([0-9A-Fa-f]{2})/) { Regexp.last_match(1).hex.chr }
  from = File.join(ROOT, 'images', path)
  abort "images/#{path}: not found" unless File.exist?(from)
  FileUtils.mkdir_p(File.dirname(File.join(out, 'public/images', path)))
  FileUtils.cp(from, File.join(out, 'public/images', path))
end

# The sidebar: index.yml's sections and topics; a page index.yml does not
# list goes under the first page of its section that links it.
listed = index['sections'].flat_map { |section| section['topics'].map { |topic| topic.is_a?(Hash) ? topic['id'] : topic } }
children = Hash.new { |hash, key| hash[key] = [] }
placed = listed.dup
queue = listed.dup
until queue.empty?
  parent = queue.shift
  pages[parent][:links].each do |link|
    next if placed.include?(link) || !pages.key?(link) || link.split('/').first != parent.split('/').first

    children[parent] << link
    placed << link
    queue << link
  end
end
orphans = pages.keys - placed

# The repository's own docs: docs/README.md is the page "About this project".
LANGUAGES.each do |lang|
  dir = File.join(out, lang == 'en' ? '' : lang)
  FileUtils.mv(File.join(dir, 'README.md'), File.join(dir, 'about.md'))
end
docs_title = ->(lang, name) { h1(File.read(File.join(out, lang == 'en' ? '' : lang, "#{name}.md"), encoding: 'UTF-8')) }

LABELS = {
  'en' => { about: 'About this project', overview: 'Overview', sponsors: 'Sponsors', license: 'License' },
  'ja' => { about: 'このプロジェクトについて', overview: '概要', sponsors: 'スポンサー', license: 'ライセンス' },
}.freeze

LANGUAGES.each do |lang|
  prefix = lang == 'en' ? '/' : "/#{lang}/"
  item = lambda do |id|
    entry = { text: pages[id][:titles][lang], link: "#{prefix}#{id}" }
    entry.merge!(collapsed: true, items: children[id].map(&item)) if children[id].any?
    entry
  end
  sidebar = [{ text: 'Redmine Guide', link: prefix }]
  index['sections'].each do |section|
    ids = section['topics'].map { |topic| topic.is_a?(Hash) ? topic['id'] : topic }
    ids += orphans.select { |id| id.start_with?("#{section['id']}/") }
    sidebar << { text: section['title'][lang], collapsed: true, items: ids.map(&item) }
  end
  sidebar << {
    text: LABELS[lang][:about],
    collapsed: true,
    items: [
      { text: LABELS[lang][:overview], link: "#{prefix}about" },
      { text: docs_title.call(lang, 'updating'), link: "#{prefix}updating" },
      { text: docs_title.call(lang, 'translating'), link: "#{prefix}translating" },
    ],
  }
  File.write(File.join(out, lang == 'en' ? '' : lang, 'sidebar.json'), "#{JSON.pretty_generate(sidebar)}\n")

  sections = index['sections'].map do |section|
    ids = section['topics'].map { |topic| topic.is_a?(Hash) ? topic['id'] : topic }
    list = ids.map { |id| "- [#{pages[id][:titles][lang]}](#{id}.md)" }
    "## #{section['title'][lang]} {##{section['id']}}\n\n#{list.join("\n")}"
  end
  docs = [
    "- [#{LABELS[lang][:overview]}](about.md)",
    "- [#{docs_title.call(lang, 'updating')}](updating.md)",
    "- [#{docs_title.call(lang, 'translating')}](translating.md)",
  ].join("\n")
  intro, about, license_text =
    if lang == 'en'
      ["The [Redmine guide](https://www.redmine.org/guide) from redmine.org as Markdown, updated for Redmine #{REDMINE}, with a Japanese translation. [Redmine Help](https://redmine-kit.github.io/redmine_help/) shows it inside Redmine, for the screen the user is on.",
       'The repository and how the guide is converted, updated and translated:',
       "The guide's English text and its images come from the Redmine wiki at https://www.redmine.org: #{COPYRIGHT}. redmine.org does not state a license for the wiki's text. Each page links its source.\n\n" \
       "The translations, the updates for Redmine #{REDMINE} and the screenshots retaken in Redmine #{REDMINE} are this project's and are released under the [Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)](#{LICENSE_URL[lang]}). See [LICENSES/CC-BY-SA-4.0.txt](../LICENSES/CC-BY-SA-4.0.txt).\n\n" \
       "The tools are released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](../LICENSE).\n\n" \
       'An unofficial project for Redmine.']
    else
      ["redmine.org の [Redmine のガイド](https://www.redmine.org/guide)を Markdown にし、Redmine #{REDMINE} に合わせて更新して、日本語に翻訳したものです。[Redmine Help](https://redmine-kit.github.io/redmine_help/ja/) が、ユーザーが開いている画面に合わせて Redmine の中に表示します。",
       'このリポジトリと、ガイドの変換、更新、翻訳の方法です。',
       "ガイドの英語の文と画像は、https://www.redmine.org の Redmine の Wiki から取得したもので、著作権は Jean-Philippe Lang と Redmine の貢献者にあります。redmine.org は、Wiki の文のライセンスを示していません。各ページに出典へのリンクがあります。\n\n" \
       "翻訳、Redmine #{REDMINE} に合わせた更新、Redmine #{REDMINE} で撮り直したスクリーンショットは、このプロジェクトが作ったもので、[クリエイティブ・コモンズ 表示 - 継承 4.0 国際 ライセンス (CC BY-SA 4.0)](#{LICENSE_URL[lang]}) で公開しています。[LICENSES/CC-BY-SA-4.0.txt](../../LICENSES/CC-BY-SA-4.0.txt) を参照してください。\n\n" \
       "ツールは、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。[LICENSE](../../LICENSE) を参照してください。\n\n" \
       'Redmine の非公式のプロジェクトです。']
    end
  sponsors = '<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>'
  top = [
    "---\neditLink: false\n---\n\n# Redmine Guide",
    intro,
    *sections,
    "## #{LABELS[lang][:about]} {#about-this-project}\n\n#{about}\n\n#{docs}",
    "## #{LABELS[lang][:sponsors]} {#sponsors}\n\n#{sponsors}",
    "## #{LABELS[lang][:license]} {#license}\n\n#{license_text}",
  ]
  File.write(File.join(out, lang == 'en' ? '' : lang, 'README.md'), "#{top.join("\n\n")}\n")
end

# The about pages are docs/README.md: no edit link to docs/about.md.
LANGUAGES.each do |lang|
  path = File.join(out, lang == 'en' ? '' : lang, 'about.md')
  File.write(path, "---\neditLink: false\n---\n\n#{File.read(path, encoding: 'UTF-8')}")
end

puts "#{pages.size} topics in #{LANGUAGES.join(', ')}, #{images.uniq.size} images, #{orphans.size} topics at the end of their section"
