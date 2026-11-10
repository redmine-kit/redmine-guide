# frozen_string_literal: true

# Fetches the Redmine guide from www.redmine.org into a directory: the wiki's
# Textile source of every page, the images the pages show (also those shown
# from redmine.org by their URL), and manifest.json
# (URL, page version, update time, fetch date). bin/fetch runs it into the
# upstream branch, so that a diff shows what changed on redmine.org.
#
# The guide is the page Guide, the pages it includes ({{include(...)}}), the
# pages they link, and the pages those link whose wiki parent is a guide page
# (e.g. the REST API resources under Rest_api). Requests are spaced out, and
# robots.txt is respected (the wiki is allowed).
require 'json'
require 'net/http'
require 'uri'
require 'fileutils'
require 'time'

Encoding.default_external = Encoding::UTF_8

BASE = 'https://www.redmine.org'
WIKI = '/projects/redmine/wiki/'
AGENT = 'redmine-kit-guide-fetch/0.1 (+https://github.com/redmine-kit/redmine-guide)'
DELAY = Float(ENV.fetch('FETCH_DELAY', '1.5'))
OUT = ARGV.fetch(0) { abort 'usage: fetch.rb <directory>' }

def get(path, redirects = 3)
  sleep DELAY
  uri = URI.join(BASE, path)
  3.times do |attempt|
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 20, read_timeout: 60) do |http|
      http.request(Net::HTTP::Get.new(uri, 'User-Agent' => AGENT))
    end
    return response.body if response.is_a?(Net::HTTPSuccess)
    return nil if response.is_a?(Net::HTTPNotFound)
    # A renamed page redirects to its new name (same site only).
    if response.is_a?(Net::HTTPRedirection) && redirects.positive?
      target = URI.join(uri, response['location'])
      return nil unless target.host == uri.host

      # A wiki page's API URL redirects to the page; ask for its JSON again.
      if uri.path.end_with?('.json') && !target.path.end_with?('.json')
        target.path = "#{target.path}.json"
        target.query = uri.query
      end
      return get(target.request_uri, redirects - 1)
    end

    warn "#{response.code} #{uri} (attempt #{attempt + 1})"
    sleep 10 * (attempt + 1)
  end
  warn "skipped: #{uri}"
  nil
end

# Pages of the guide in other languages (FrGuide, RusGuide, RusRedmineGantt,
# KoreanWikiFormatting, ...) are other translations; the guide here is the
# English one.
def other_language?(name)
  name.match?(/\A[A-Za-z]{2,3}(?:BR)?Guide\z/) ||
    name.match?(/\A(?:Rus|Ru|Br|Fr|De|Es|Ko|Ja|PtBR)Redmine[A-Z]/) ||
    name.match?(/\A(?:Korean|SimplifiedChinese|TraditionalChinese|Turkish)WikiFormatting\z/)
end

# Wiki page names in Textile links: [[Page]], [[Page|label]], [[Page#anchor|label]].
# [[project:Page]] is another project and skipped.
def links(text)
  text.scan(/\[\[([^\]|#:]+)(?:#[^\]|]*)?(?:\|[^\]]*)?\]\]/).flatten.map { |name| name.strip.tr(' ', '_') }.uniq
end

def includes(text)
  text.scan(/\{\{include\(([^)]+)\)\}\}/).flatten.map { |name| name.strip.tr(' ', '_') }.uniq
end

# !image.png!, !>image.png!, !{width: 100px}.image@2x.png! (style, then a dot)
def images(text)
  text.scan(/!(?:[<>=]|\{[^}]*\}\.?)*([^!\s(]+\.(?:png|jpe?g|gif|svg))(?:\([^)]*\))?!/i).flatten.uniq
end

# An image a page shows from redmine.org by its URL
# (!http://www.redmine.org/attachments/7069/Redmine_logo.png!): its
# attachment, fetched with the page's own images, so that the guide shows no
# image from another site.
EXTERNAL_IMAGE = %r{\Ahttps?://(?:www\.)?redmine\.org/attachments/(?:download/)?(\d+)/([^/?#]+)\z}

def external_images(shown)
  shown.filter_map do |src|
    match = src.match(EXTERNAL_IMAGE)
    match && { 'filename' => match[2], 'content_url' => "#{BASE}/attachments/download/#{match[1]}/#{match[2]}", 'source' => src }
  end
end

pages = {}
queue = [['Guide', 0, nil]]
seen = {}
until queue.empty?
  name, depth, from = queue.shift
  key = name.downcase
  next if seen[key] || other_language?(name)

  seen[key] = true
  body = get("#{WIKI}#{URI.encode_www_form_component(name).gsub('+', '%20')}.json?include=attachments")
  unless body
    warn "missing: #{name} (linked from #{from})"
    next
  end
  page = JSON.parse(body)['wiki_page']
  title = page['title']
  parent = page.dig('parent', 'title')
  # Depth 2 pages are kept only under a guide page in the wiki's hierarchy.
  if depth >= 2 && !(parent && pages.key?(parent))
    next
  end

  pages[title] = {
    'url' => "#{BASE}#{WIKI}#{title}",
    'version' => page['version'],
    'updated_on' => page['updated_on'],
    'parent' => parent,
    'linked_from' => from,
    'text' => page['text'].gsub("\r\n", "\n"),
    'attachments' => (page['attachments'] || []).map { |a| a.slice('filename', 'content_url', 'filesize') },
  }
  includes(page['text']).each { |n| queue << [n, depth, title] }
  links(page['text']).each { |n| queue << [n, depth + 1, title] } if depth < 2
  warn "#{pages.size} #{title} (v#{page['version']})"
end

FileUtils.rm_rf(Dir[File.join(OUT, '{pages,images}')])
FileUtils.mkdir_p(File.join(OUT, 'pages'))
manifest = { 'source' => "#{BASE}/guide", 'fetched_at' => Time.now.utc.iso8601, 'pages' => {} }
pages.sort.each do |title, page|
  File.write(File.join(OUT, 'pages', "#{title}.textile"), page['text'])
  shown = images(page['text'])
  external = external_images(shown)
  files = page['attachments'].select { |a| shown.include?(a['filename']) } + external
  files.each do |file|
    data = get(URI(file['content_url']).path)
    next unless data

    dir = File.join(OUT, 'images', title)
    FileUtils.mkdir_p(dir)
    File.binwrite(File.join(dir, file['filename']), data)
  end
  manifest['pages'][title] = page.except('text', 'attachments').merge('images' => files.map { |f| f['filename'] })
  manifest['pages'][title]['image_sources'] = external.to_h { |f| [f['filename'], f['source']] } if external.any?
end
File.write(File.join(OUT, 'manifest.json'), "#{JSON.pretty_generate(manifest)}\n")
warn "#{pages.size} pages"
