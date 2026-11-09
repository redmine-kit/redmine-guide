# frozen_string_literal: true

# Checks the guide (docs/translating.md):
# - every relative link in en/ and the translations resolves;
# - a translation records the English page's version it was translated from
#   (translated_from_version); a newer English page makes it stale;
# - interface terms: each term the English page marks in bold (**Apply**)
#   that the glossary knows must appear in the translation as Redmine's own
#   string in that language, marked as a name (「適用」 or **適用**);
# - index.yml lists only existing topics, and map.yml's topics and
#   anchors exist.
#
#   ruby check.rb <guide directory>
require 'yaml'

Encoding.default_external = Encoding::UTF_8

ROOT = ARGV.fetch(0)
problems = []

def front_matter(text)
  text[/\A---\n(.*?)\n---\n/m, 1].then { |yaml| yaml ? YAML.safe_load(yaml) : {} }
end

def links(text)
  text.gsub(/```.*?```/m, '').scan(/\]\(([^)\s]+)\)/).flatten
end

languages = Dir.children(ROOT).select { |name| name.match?(/\A[a-z]{2}\z/) && File.directory?(File.join(ROOT, name)) }
languages.each do |lang|
  Dir.glob('**/*.md', base: File.join(ROOT, lang)).sort.each do |file|
    path = File.join(ROOT, lang, file)
    text = File.read(path)
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

index = YAML.safe_load_file(File.join(ROOT, 'index.yml'))
index['sections'].each do |section|
  section['topics'].each do |topic|
    problems << "index.yml: missing topic #{topic}" unless File.exist?(File.join(ROOT, 'en', "#{topic}.md"))
  end
end

puts problems
warn "#{problems.size} problems"
exit(problems.empty? ? 0 : 1)
