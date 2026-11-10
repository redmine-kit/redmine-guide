# frozen_string_literal: true

# Checks the guide (docs/translating.md):
# - every relative link in en/ and the translations resolves;
# - a translation records the English page's version it was translated from
#   (translated_from_version); a newer English page makes it stale;
# - interface terms: each term the English page marks in bold (**Apply**)
#   that the glossary knows must appear in the translation as Redmine's own
#   string in that language, marked as a name (「適用」 or **適用**);
# - index.yml lists only existing topics, each with a title in every
#   language the index uses, and map.yml's topics and anchors exist;
# - every updates/<topic>.yml has its topic;
# - a translation's H1 is the page's title in glossary/<lang>.pages.yml, and
#   its headings match the English page's one for one (same count and
#   levels): redmine_help finds an English anchor in a translation by the
#   heading's position, so translations need no anchors of their own.
#
# - the conversion left no Textile behind and broke nothing that a reader
#   would see (the conversion's known failures: <code class> in code
#   blocks, macros, escaped list markers, lists split by <!-- -->, broken
#   links such as ![#124](...), HTML tags that Markdown would hide, Textile
#   headings, footnotes, tables and links), in en/ and the translations.
#
#   ruby check.rb <guide directory>
require 'yaml'

Encoding.default_external = Encoding::UTF_8

ROOT = ARGV.fetch(0)
problems = []

def front_matter(text)
  text[/\A---\n(.*?)\n---\n/m, 1].then { |yaml| yaml ? YAML.safe_load(yaml) : {} }
end

def headings(text)
  text.gsub(/^```.*?^```/m, '').scan(/^(#+)[ \t]+(.+)$/)
end

def links(text)
  # Not an escaped example of the syntax (\![\](image.png)).
  text.gsub(/```.*?```/m, '').scan(/(?<!\\)\]\(([^)\s]+)\)/).flatten
end

# The text outside code: fenced and indented blocks and code spans removed.
def prose(text)
  text.sub(/\A---\n.*?\n---\n/m, '').gsub(/^[ \t]*(`{3,}|~{3,}).*?^[ \t]*\1\s*$/m, '').gsub(/^(?: {4}|\t).*$/, '').gsub(/(`+).+?\1/, '')
end

# HTML that Markdown shows (the guide's tables, footnotes, collapsed
# sections, spans); any other tag would be hidden.
HTML_TAGS = %w[a blockquote br code del details div em img ins kbd li ol p pre span strong sub summary sup table tbody td th thead tr u ul].freeze
CONVERSION_FAILURES = {
  /^\s*<code class="[^"]*">\s*$/ => '<code class> in a code block',
  /\{\{[a-z_>]/i => 'a macro left in the text',
  /^\\\*/ => 'an escaped list marker (\\*)',
  /^<!-- -->$/ => 'a list split in two (<!-- -->)',
  /!\[#\d/ => 'a broken link (![#...])',
  /^(?:h[1-6]|bq|fn\d+)\.\s|^\\>/ => 'a Textile heading, quote or footnote',
  /^\|(?:_|[\\\/]\d)/ => 'a Textile table',
  /"[^"\n]+":(?:https?:|\/)/ => 'a Textile link',
  /\[\^\d+\]/ => 'a footnote marker that is not Redmine\'s',
  /RG[A-Z]+x\d+x|RGHASH/ => 'a placeholder of the conversion',
  /(?<![<\w])(?:span|div|img|a|p) [a-z-]+=["”]/ => 'the text of an HTML tag shown',
  /^(?:- |\* |\+ ).*\n\n {4}(?![-*+ ]|\d+\.)\S/ => 'an indented code block taken into a list item',
}.freeze
# Found in the text with its indented code (the others: outside code).
IN_CODE = ['<code class> in a code block', 'an indented code block taken into a list item'].freeze

# An indented code block (Markdown): a line indented by four spaces or a tab
# after a blank line, outside fenced blocks, lists and HTML blocks. Code
# blocks are fenced, with a language or `text`, so that all look the same.
def indented_code?(text)
  fence = nil
  list = html = false
  blank = true
  text.sub(/\A---\n.*?\n---\n/m, '').each_line(chomp: true) do |line|
    if fence
      fence = nil if line.strip.start_with?(fence) && line.strip.delete(fence[0]).empty?
      next
    end
    if (fence = line[/\A\s*(`{3,}|~{3,})/, 1])
      # A fence at the margin ends a list.
      list &&= !line.match?(/\A[`~]/)
      blank = false
      next
    end
    if line.strip.empty?
      blank = true
      html = false
      next
    end
    indented = line.match?(/\A(?: {4}|\t)/)
    return true if indented && blank && !list && !html

    unless indented
      list = line.match?(/\A\s*(?:[-*+]|\d+[.)])\s/) || (list && line.match?(/\A\s+\S/))
      html ||= blank && line.match?(%r{\A<[a-zA-Z/!]})
    end
    blank = false
  end
  false
end

# Full-width characters in a line of a code block drawn as aligned ASCII art
# (columns of | or +-): a code font does not draw them exactly two columns
# wide, so the columns do not line up. Use ASCII and a legend below.
FULL_WIDTH = /[\p{Han}\p{Hiragana}\p{Katakana}\u3000-\u303F\uFF01-\uFF60]/

def full_width_art?(text)
  fence = nil
  text.each_line(chomp: true).any? do |line|
    if fence
      fence = nil if line.strip.start_with?(fence) && line.strip.delete(fence[0]).empty?
      fence && line.match?(FULL_WIDTH) && (line.count('|') >= 2 || line.match?(/\+-|-\+/))
    else
      fence = line[/\A\s*(`{3,}|~{3,})/, 1]
      false
    end
  end
end

# A fenced block that holds a fence of its own (```` around ```text), or whose
# lines all keep the indentation of an indented block.
def fence_problems(text)
  problems = []
  fence = nil
  fence_indent = ''
  body = []
  text.each_line(chomp: true) do |line|
    if fence
      if line.strip.start_with?(fence) && line.strip.delete(fence[0]).empty?
        lines = body.reject { |l| l.strip.empty? }
        problems << 'a code fence inside a fenced block' if body.any? { |l| l.match?(/\A\s*(`{3,}|~{3,})\S/) }
        problems << 'a fenced block whose lines all keep a 4-space indent' if lines.any? && lines.all? { |l| l.start_with?(fence_indent + '    ') }
        fence = nil
      else
        body << line
      end
    elsif (fence = line[/\A\s*(`{3,}|~{3,})/, 1])
      fence_indent = line[/\A\s*/]
      body = []
    end
  end
  problems.uniq
end

# Parentheses in Japanese text (AGENTS.md of the organization): half-width,
# with a space before and after, but none next to Japanese punctuation or a
# bracket. Code, link targets, HTML tags, URLs and Redmine's own strings
# (`strings`, quoted as Redmine writes them) are left out.
JAPANESE = /[\p{Hiragana}\p{Katakana}\p{Han}ー]/
JAPANESE_PUNCTUATION = '、。・：；！？「」『』【】'

def parenthesis_problems(text, strings)
  # As prose, but code spans stand for a word (`x`), not for nothing.
  body = text.sub(/\A---\n.*?\n---\n/m, '').gsub(/^[ \t]*(`{3,}|~{3,}).*?^[ \t]*\1\s*$/m, '').gsub(/(`+).+?\1/, 'x')
             .gsub(/\]\([^)\s]*\)|<[^<>\n]+>|https?:\/\/[^\s)<>]+/, ' ')
  strings.each { |string| body = body.gsub(string, ' ') }
  found = []
  found << 'full-width parentheses' if body.match?(/[（）]/)
  found << 'a parenthesis next to Japanese text without a space' if body.match?(/#{JAPANESE}\(|\)#{JAPANESE}/)
  found << 'a space between Japanese punctuation and a parenthesis' if body.match?(/[#{JAPANESE_PUNCTUATION}] +\(|\) +[#{JAPANESE_PUNCTUATION}]/)
  found.map { |problem| "#{problem} (half-width, with a space before and after)" }
end

# The text formatting pages show inline styles as examples.
STYLE_EXAMPLES = %r{\Auser/text-formatting}

def conversion_failures(text, file = '')
  body = prose(text)
  unfenced = text.gsub(/^[ \t]*(`{3,}|~{3,}).*?^[ \t]*\1\s*$/m, '')
  found = CONVERSION_FAILURES.filter_map { |pattern, problem| problem if (IN_CODE.include?(problem) ? unfenced : body).match?(pattern) }
  found << 'an indented code block (fence it, with a language or `text`)' if indented_code?(text)
  found.concat(fence_problems(text)) unless file.match?(STYLE_EXAMPLES)
  found << 'full-width characters in ASCII art of a code block (use ASCII and a legend)' if full_width_art?(text)
  found << 'an image from another site (keep a copy in images/)' if body.match?(/(?<!\\)!\[(?:[^\]\\]|\\.)*\]\(\s*<?https?:|<img\b[^>]*\bsrc=["']?https?:/i)
  found << 'an inline background colour (a note is an alert: > [!NOTE])' if !file.match?(STYLE_EXAMPLES) && body.match?(/style="[^"]*background/i)
  tags = body.scan(%r{(?<!\\)</?([A-Za-z][A-Za-z0-9]*)[\s>/]}).flatten.map(&:downcase).uniq - HTML_TAGS
  found << "HTML tags that Markdown would hide (#{tags.map { |tag| "<#{tag}>" }.join(', ')})" unless tags.empty?
  found
end

languages = Dir.children(ROOT).select { |name| name.match?(/\A[a-z]{2}\z/) && File.directory?(File.join(ROOT, name)) }
languages.each do |lang|
  Dir.glob('**/*.md', base: File.join(ROOT, lang)).sort.each do |file|
    path = File.join(ROOT, lang, file)
    text = File.read(path)
    conversion_failures(text, file).each { |problem| problems << "#{lang}/#{file}: #{problem}" }
    links(text).each do |href|
      next if href.match?(/\A([a-z]+:|#)/i)
      # Only links to pages and images; the text formatting pages show syntax.
      next unless href.split('#').first.match?(/\.(md|png|jpe?g|gif|svg)\z/i)

      target = File.expand_path(href.split('#').first, File.dirname(path))
      # A page not translated yet is shown in English (redmine_help's fallback).
      english = target.sub(File.expand_path(File.join(ROOT, lang)), File.expand_path(File.join(ROOT, 'en')))
      problems << "#{lang}/#{file}: broken link #{href}" unless File.exist?(target) || File.exist?(english)
    end
  end
end

(languages - ['en']).each do |lang|
  glossary_file = File.join(ROOT, 'glossary', "#{lang}.yml")
  extra_file = File.join(ROOT, 'glossary', "#{lang}.extra.yml")
  terms = Hash.new { |hash, key| hash[key] = [] }
  [glossary_file, extra_file].select { |f| File.exist?(f) }.each do |f|
    Array(YAML.safe_load_file(f)['terms']).each { |term| terms[term['en']] << term[lang] }
  end
  # Redmine's strings with parentheses, which translations quote as they are.
  ui_strings = terms.values.flatten.compact.select { |string| string.match?(/[()（）]/) }.uniq.sort_by { |string| -string.size }
  pages_file = File.join(ROOT, 'glossary', "#{lang}.pages.yml")
  titles = File.exist?(pages_file) ? YAML.safe_load_file(pages_file)['pages'] || {} : {}
  titles.each_key { |topic| problems << "glossary/#{lang}.pages.yml: no topic #{topic}" unless File.exist?(File.join(ROOT, 'en', "#{topic}.md")) }
  Dir.glob('**/*.md', base: File.join(ROOT, lang)).sort.each do |file|
    source = File.join(ROOT, 'en', file)
    unless File.exist?(source)
      problems << "#{lang}/#{file}: no English page en/#{file}"
      next
    end
    english = File.read(source)
    translation = File.read(File.join(ROOT, lang, file))
    from = front_matter(translation)['translated_from_version']
    current = front_matter(english)['source_version']
    if from.nil?
      problems << "#{lang}/#{file}: no translated_from_version"
    elsif current && from.to_i < current.to_i
      problems << "#{lang}/#{file}: stale, translated from version #{from}, English page is version #{current}"
    end
    title = titles.dig(file.delete_suffix('.md'), lang)
    h1 = translation[/^#[ \t]+(.+)$/, 1]&.strip
    problems << "#{lang}/#{file}: title \"#{h1}\" should be \"#{title}\" (glossary/#{lang}.pages.yml)" if title && h1 != title
    levels = ->(text) { headings(text).map { |marks, _| marks.size } }
    unless levels.call(english) == levels.call(translation)
      problems << "#{lang}/#{file}: headings differ from the English page (#{levels.call(english).size} in English, #{levels.call(translation).size} here)"
    end
    problems << "#{lang}/#{file}: anchor tag; keep the headings one for one instead" if translation.match?(/<a\s+(id|name)=/)
    if lang == 'ja'
      parenthesis_problems(translation, ui_strings).each { |problem| problems << "#{lang}/#{file}: #{problem}" }
    end
    english.scan(/\*\*([^*\n]+)\*\*/).flatten.uniq.each do |term|
      expected = terms[term.strip]
      # Marked as an interface name: 「適用」 or **適用**.
      next if expected.empty? || expected.any? { |word| translation.include?("「#{word}」") || translation.include?("**#{word}**") }

      problems << "#{lang}/#{file}: interface term \"#{term}\" should be #{expected.uniq.map { |w| "「#{w}」" }.join(' or ')}"
    end
  end
end

# map.yml: every topic exists, and every anchor is a heading of its page
# (Redmine's anchors: ApplicationHelper#sanitize_anchor_name).
anchor = ->(text) { text.gsub(/[^\s\-\p{Word}]/, '').gsub(/\s+(-+\s*)?/, '-') }
YAML.safe_load_file(File.join(ROOT, 'map.yml')).each do |screen, value|
  topic, fragment = value.to_s.split('#', 2)
  file = File.join(ROOT, 'en', "#{topic}.md")
  unless File.exist?(file)
    problems << "map.yml: #{screen}: no topic #{topic}"
    next
  end
  headings = File.read(file).scan(/^#+\s+(.+)$/).flatten.map { |heading| anchor.call(heading.strip) }
  problems << "map.yml: #{screen}: no heading ##{fragment} in #{topic}" if fragment && !headings.include?(fragment)
end

# updates/<topic>.yml: the topic exists (bin/convert applies the updates).
Dir.glob('updates/**/*.yml', base: ROOT).each do |file|
  topic = file.delete_prefix('updates/').delete_suffix('.yml')
  problems << "#{file}: no topic #{topic}" unless File.exist?(File.join(ROOT, 'en', "#{topic}.md"))
end

index = YAML.safe_load_file(File.join(ROOT, 'index.yml'))
# The languages of the index: a topic without a title in one of them shows
# its id, or a title in another language, in that language's sidebar.
index_languages = index['sections'].flat_map do |section|
  section['title'].keys + section['topics'].flat_map { |entry| entry.is_a?(Hash) ? entry['title'].keys : [] }
end.uniq.sort
index['sections'].each do |section|
  section['topics'].each do |entry|
    topic = entry.is_a?(Hash) ? entry['id'] : entry
    problems << "index.yml: missing topic #{topic}" unless File.exist?(File.join(ROOT, 'en', "#{topic}.md"))
    missing = index_languages - (entry.is_a?(Hash) ? entry['title'].keys : [])
    problems << "index.yml: #{topic}: no title in #{missing.join(', ')}" unless missing.empty?
  end
end

puts problems
warn "#{problems.size} problems"
exit(problems.empty? ? 0 : 1)
