# frozen_string_literal: true

# The parts of Redmine's Textile that pandoc's Textile reader gets wrong,
# rendered by the converter itself or rewritten before pandoc sees them
# (docs/updating.md#conversion). Each follows what Redmine shows
# (lib/redmine/wiki_formatting/textile/redcloth3.rb):
#
# - <pre> blocks are literal, with nested <pre> and <code class="...">;
# - only <pre>, <code>, <kbd> and <notextile> are HTML, other tags are text;
# - fnN. paragraphs and [N] markers are footnotes, shown where they are;
# - table cells can span rows and columns and be aligned;
# - list items may be indented to nest them;
# - ! before a Redmine link (!#124) shows the link's text;
# - {{collapse(Label) ... }} is a collapsed section;
# - <notextile> text is shown as it is;
# - %{style}text% is a styled span, also before punctuation;
# - lines that start with > are a quote.
require 'cgi'
require 'open3'

module Textile
  # Blocks kept out of pandoc: a placeholder paragraph in the Textile, put
  # back as Markdown (or HTML) after the conversion.
  class Held
    def initialize
      @blocks = []
    end

    # A block (a paragraph of its own), or inline text.
    def hold(markdown, inline: false)
      @blocks << markdown
      inline ? "RGHELDx#{@blocks.size - 1}x" : "\n\nRGHELDx#{@blocks.size - 1}x\n\n"
    end

    def restore(markdown)
      while markdown.match?(/RGHELDx\d+x/)
        # A code block within a list item, on a line of its own.
        markdown = markdown.gsub(/\\?\n([ \t]+)RGHELDx(\d+)x\\?[ \t]*$/) do
          block = @blocks[Regexp.last_match(2).to_i]
          block.is_a?(Code) ? "\n\n#{block.to_s(Regexp.last_match(1))}\n" : Regexp.last_match(0)
        end
        # An indented code block right after a list would be taken into the
        # list's last item: fenced instead.
        markdown = markdown.gsub(/(?<=\n\n)RGHELDx(\d+)x$/) do
          block = @blocks[Regexp.last_match(1).to_i]
          after_list = Regexp.last_match.pre_match.rstrip.split("\n").last.to_s.match?(/\A(?:\s*(?:[-*+]|\d+\.)\s|\s+\S)/)
          block.is_a?(Code) && after_list ? block.to_s(fenced: true) : Regexp.last_match(0)
        end
        markdown = markdown.gsub(/RGHELDx(\d+)x/) { @blocks[Regexp.last_match(1).to_i].to_s }
      end
      markdown
    end

    # The code held in the cells of a table written as HTML.
    def html(text)
      text.gsub(/RGHELDx(\d+)x/) { @blocks[Regexp.last_match(1).to_i].to_html }
    end
  end

  # Text that Redmine shows as it is (<notextile>): a placeholder, put back
  # escaped for Markdown or for HTML.
  class Literals
    def initialize
      @texts = []
    end

    def hold(text)
      @texts << text
      "RGLITx#{@texts.size - 1}x"
    end

    def markdown(text)
      text.gsub(/RGLITx(\d+)x/) { @texts[Regexp.last_match(1).to_i].gsub(/([\\`*_\[\]<>|#~])/, '\\\\\1') }
    end

    def html(text)
      text.gsub(/RGLITx(\d+)x/) { CGI.escapeHTML(@texts[Regexp.last_match(1).to_i]) }
    end
  end

  module_function

  # <pre> blocks (and <pre><code class="lang">) as code blocks, their content
  # as it is: Redmine shows it literally, also when it contains <pre>.
  def extract_pre(text, held)
    out = +''
    pos = 0
    while (start = text.index(/<pre\b[^>]*>/i, pos))
      out << text[pos...start]
      depth = 0
      close_start = close_end = nil
      text.to_enum(:scan, %r{<(/?)pre\b[^>]*>}i).each do
        match = Regexp.last_match
        next if match.begin(0) < start

        depth += match[1].empty? ? 1 : -1
        next unless depth.zero?

        close_start = match.begin(0)
        close_end = match.end(0)
        break
      end
      open_end = text.index('>', start) + 1
      close_start ||= close_end = text.size
      inner = text[open_end...close_start]
      line_start = text.rindex("\n", start - 1) || -1
      line_end = text.index("\n", close_end) || text.size
      paragraph = text[0...start].split(/\n[ \t]*\n/).last.to_s
      if paragraph.match?(/\A[ \t]*\|/) && !paragraph.match?(/\|[ \t]*\n[^\n]*\z/)
        # <pre> in a table cell (rendered as HTML by +tables+).
        out << held.hold(code_block(inner), inline: true)
      elsif !inner.strip.include?("\n") && !(text[(line_start + 1)...start] + text[close_end...line_end]).strip.empty?
        # <pre> within a line, such as a list item: inline code.
        out << held.hold(Span.new(inner.strip), inline: true)
      elsif text[0...start].match?(/^[ \t]*[*#]+[ \t][^\n]*\n\z/)
        # A block right after a list item, within the item (on a line of its
        # own).
        out << held.hold(code_block(inner), inline: true)
        out << "\n" unless text[close_end...line_end].strip.empty?
      else
        out << held.hold(code_block(inner))
      end
      pos = close_end
    end
    out << text[pos..]
  end

  # HTML written as it is, in Markdown and in a table's HTML.
  Raw = Struct.new(:html) do
    alias_method :to_s, :html
    alias_method :to_html, :html
  end

  # Inline code.
  Span = Struct.new(:text) do
    def to_s
      ticks = '`'
      ticks += '`' while text.include?(ticks)
      space = text.start_with?('`') || text.end_with?('`') ? ' ' : ''
      "#{ticks}#{space}#{text}#{space}#{ticks}"
    end

    def to_html
      "<code>#{CGI.escapeHTML(text)}</code>"
    end
  end

  # @code@ (RedCloth3's CODE_RE: not within a word): inline code, also next
  # to / and other punctuation, which pandoc misses.
  def inline_code(text, held)
    text.gsub(/(?<=\A|[^\w@])@(?:\|\w+?\|)?([^\n]+?)@(?=[^\w@]|\z)/) { held.hold(Span.new(Regexp.last_match(1)), inline: true) }
  end

  # <notextile>...</notextile> (outermost, not empty) as literal text.
  def notextile(text, literals)
    out = +''
    pos = 0
    while (start = text.index('<notextile>', pos))
      out << text[pos...start]
      depth = 0
      close = nil
      text.to_enum(:scan, %r{<(/?)notextile>}).each do
        match = Regexp.last_match
        next if match.begin(0) < start

        depth += match[1].empty? ? 1 : -1
        if depth.zero?
          close = match
          break
        end
      end
      break out << text[start..] unless close

      inner = text[(start + '<notextile>'.size)...close.begin(0)]
      out << (inner.empty? ? close.pre_match[start..] + close[0] : literals.hold(inner))
      pos = close.end(0)
    end
    out << text[pos..] if pos < text.size
    out
  end

  # %{color: red}text%: a span with the style (pandoc needs a space after
  # it).
  def styled_spans(text, held)
    text.split(/(@[^@\n]+@)/).each_with_index.map do |part, index|
      next part if index.odd?

      part.gsub(/%\{([^}\n]*)\}([^%\n]+)%/) do
        # The tags are held: pandoc reads <span after * as an attribute.
        held.hold(Raw.new(%(<span style="#{CGI.escapeHTML(Regexp.last_match(1).strip)}">)), inline: true) +
          Regexp.last_match(2) + held.hold(Raw.new('</span>'), inline: true)
      end
    end.join
  end

  # A code block: fenced with its language, or indented (fenced within a
  # list item).
  Code = Struct.new(:lines, :lang) do
    def to_s(indent = '', fenced: false)
      return '' if lines.all?(&:empty?)

      if (lang && !lang.empty?) || !indent.empty? || fenced
        fence = '```'
        fence += '`' while lines.any? { |line| line.include?(fence) }
        ["#{fence}#{lang}", *lines, fence].map { |line| line.empty? ? '' : "#{indent}#{line}" }.join("\n")
      else
        lines.map { |line| line.empty? ? '' : "    #{line}" }.join("\n")
      end
    end

    def to_html
      attribute = lang && !lang.empty? ? %( class="#{CGI.escapeHTML(lang)}") : ''
      "<pre><code#{attribute}>#{lines.map { |line| CGI.escapeHTML(line) }.join("\n")}</code></pre>"
    end
  end

  def code_block(inner)
    lang = nil
    if (match = inner.match(%r{\A\s*<code(?:\s+class=["']([^"']*)["'])?[^>]*>(.*?)(?:</code>)?\s*\z}m))
      lang = match[1]&.sub(/\Alanguage-/, '')
      inner = match[2]
    end
    Code.new(inner.sub(/\A[ \t]*\r?\n/, '').sub(/\s+\z/, '').split("\n").map(&:rstrip), lang)
  end

  # Tags other than pre, code, kbd and notextile are text in Redmine
  # (RedCloth3#escape_html_tags): <Accesskey> is shown, not dropped.
  ALLOWED_TAGS = %w[pre code kbd notextile].freeze

  def escape_html_tags(text)
    text.split(/(@[^@\n]+@)/).each_with_index.map do |part, index|
      next part if index.odd?

      part.gsub(%r{<(/?)([A-Za-z][^\s<>/]*)([^<>\n]*)>}) do
        ALLOWED_TAGS.include?(Regexp.last_match(2)) ? Regexp.last_match(0) : "&#60;#{Regexp.last_match(1)}#{Regexp.last_match(2)}#{Regexp.last_match(3)}>"
      end
    end.join
  end

  # !#124, !r758, !document#17, !sandbox:source:file...: the escaped link's
  # text. The # stays out of reach of the issue links (restored by
  # restore_hashes).
  ESCAPED_LINK = %r{(?<=\A|[\s*(\[>,|])!(?=##?\d|#note-|@\w|[a-z]+#\d|[a-z0-9_-]+\|r?\w|r\d|[a-z0-9_-]+:(?!//))}

  def unescape_links(text)
    text.gsub(/#{ESCAPED_LINK}(\S*)/o) { Regexp.last_match(1).gsub('#', 'RGHASH') }
  end

  def restore_hashes(text)
    text.gsub('RGHASH', '#')
  end

  # Footnotes as Redmine shows them: the marker as a superscript number, the
  # note as a paragraph that starts with it.
  def mark_footnotes(text)
    notes = text.scan(/^fn(\d+)\.\s/).flatten
    return text if notes.empty?

    text.gsub(/^fn(\d+)\.[ \t]+/) { "RGFNDEFx#{Regexp.last_match(1)}x " }
        .gsub(/(?<=[^\s\[|])\[(\d+)\](?![\w(\[])/) { notes.include?(Regexp.last_match(1)) ? "RGFNREFx#{Regexp.last_match(1)}x" : Regexp.last_match(0) }
  end

  def footnotes(text)
    text.gsub(/RGFN(?:DEF|REF)x(\d+)x/) { "<sup>#{Regexp.last_match(1)}</sup>" }
  end

  # Nested list items written with indentation (Redmine needs ** for them):
  # each deeper indentation is one level deeper. Blank lines between items of
  # one list are dropped, so that the list is not cut in two.
  LIST_ITEM = /\A([ \t]*)([*#]+)[ \t]+/

  def normalize_lists(text)
    lines = text.split("\n", -1)
    out = []
    index = 0
    while index < lines.size
      unless lines[index].match?(LIST_ITEM)
        out << lines[index]
        index += 1
        next
      end
      run = []
      split = false
      while index < lines.size
        line = lines[index]
        if (item = line.match(LIST_ITEM))
          first = run.first&.match(LIST_ITEM)
          # A list of the other kind (* and #) at the same level: a new list.
          break split = true if first && item[2] != first[2] && item[2].size == 1 && first[2].size == 1 && item[1].size <= first[1].size

          run << line
          index += 1
        elsif !line.strip.empty? && !line.match?(/\A\s*(?:\||RGTABLEx|(?:h[1-6]|p|bq|fn\d+|table)[.({<>=])/)
          # The item continues on the next line (Redmine's list goes on
          # until a blank line); pandoc needs it indented.
          run << (line.match?(/\A\s/) ? line : "  #{line}")
          index += 1
        elsif line.strip.empty?
          following = index
          following += 1 while following < lines.size && lines[following].strip.empty?
          next_item = lines[following]&.match(LIST_ITEM)
          break unless next_item && (!next_item[1].empty? || (next_item[2].start_with?('*') && run.reverse.find { |item| item.match?(LIST_ITEM) }[LIST_ITEM, 2].start_with?('*')))

          index = following
        else
          break
        end
      end
      indents = run.filter_map { |item| item[LIST_ITEM, 1]&.size }.uniq.sort
      run.each do |item|
        next out << item unless item.match?(LIST_ITEM)

        indent, marks = item.match(LIST_ITEM).captures
        level = indents.index(indent.size) + marks.size
        out << item.sub(LIST_ITEM) { "#{marks[0] * level} " }
      end
      out << '' if split
    end
    out.join("\n")
  end

  # Lines that start with > (RedCloth3#block_textile_quotes): a quote, one
  # level per >.
  def quotes(text, held)
    text.gsub(/(?:^>+[^\n]*(?:\n|\z))+/) do |match|
      out = +''
      level = 0
      match.split("\n").each do |line|
        marks, content = line.match(/\A([> ]+)(.*)\z/).captures
        depth = marks.count('>')
        if depth != level
          tags = depth > level ? '<blockquote>' * (depth - level) : '</blockquote>' * (level - depth)
          out << held.hold(Raw.new(tags))
          level = depth
        end
        out << "#{content}\n"
      end
      out << held.hold(Raw.new('</blockquote>' * level))
    end
  end

  # {{collapse(Show, Hide) ... }}: a <details> section with the first label.
  def collapse_label(args)
    label = args.to_s.split(',').first.to_s.strip
    CGI.escapeHTML(label.empty? ? 'Show' : label)
  end

  def collapse(text, held)
    text.gsub(/^\{\{collapse(?:\(([^\n]*)\))?[ \t]*\n(.*?)\n\}\}[ \t]*$/m) do
      body = Regexp.last_match(2)
      held.hold("<details>\n<summary>#{collapse_label(Regexp.last_match(1))}</summary>") + body + held.hold('</details>')
    end
  end

  # Tables that pandoc cannot render: cells spanning rows or columns, aligned
  # cells, rows that start with spaces, footnote markers or collapsed
  # sections in cells. They are written as HTML here, with each cell's text
  # converted by pandoc and then by +inline+ (links of the guide).
  CELL_ATTRIBUTES = /\A(_)?((?:[\\\/]\d+|<>|[<>=^~-]|\{[^}]*\})*)\.[ \t]*/

  def tables(text, held, &inline)
    lines = text.split("\n", -1)
    out = []
    found = []
    index = 0
    while index < lines.size
      unless lines[index].match?(/\A[ \t]*\|/)
        out << lines[index]
        index += 1
        next
      end
      rows = []
      while index < lines.size && lines[index].match?(/\A[ \t]*\|/)
        row = lines[index]
        index += 1
        while !row.rstrip.end_with?('|') && index < lines.size && !lines[index].strip.empty?
          row = "#{row}\n#{lines[index]}"
          index += 1
        end
        rows << row
      end
      if special_table?(rows)
        style = out.pop[/\Atable(?:\{([^}]*)\})?\.\s*\z/, 1].to_s if out.last&.match?(/\Atable(?:\{[^}]*\})?\.\s*\z/)
        found << [rows, style]
        out << "RGTABLEx#{found.size - 1}x"
      else
        out.concat(rows.flat_map { |row| row.split("\n") })
      end
    end
    text = out.join("\n")
    return text if found.empty?

    parsed = found.map { |rows, _| rows.map { |row| parse_row(row) } }
    cells = parsed.flatten(2)
    html = cells_to_html(cells.flat_map { |cell| cell[:segments].grep(String) }, &inline)
    cells.each { |cell| cell[:html] = cell[:segments].map { |segment| segment.is_a?(String) ? html.shift : segment[:html] }.join }
    text.gsub(/^RGTABLEx(\d+)x$/) { held.hold(table_html(parsed[Regexp.last_match(1).to_i], found[Regexp.last_match(1).to_i][1])).strip }
  end

  def special_table?(rows)
    rows.any? do |row|
      row.match?(/\A[ \t]+\|/) || row.include?('{{collapse') || row.include?('RGFNREFx') ||
        split_cells(row).any? { |cell| (attributes = cell[CELL_ATTRIBUTES, 2]) && !attributes.empty? }
    end
  end

  def split_cells(row)
    row.strip.delete_prefix('|').delete_suffix('|').split('|', -1)
  end

  def parse_row(row)
    split_cells(row).map do |cell|
      header, attributes = cell.match(CELL_ATTRIBUTES)&.captures
      content = attributes || header ? cell.sub(CELL_ATTRIBUTES, '') : cell
      attributes = attributes.to_s
      style = []
      marks = attributes.gsub(/\{[^}]*\}/, '')
      style << "text-align: #{{ '<' => 'left', '>' => 'right', '=' => 'center', '<>' => 'justify' }[Regexp.last_match(1)]};" if marks =~ /(<>|<|>|=)/
      style << "vertical-align: #{{ '^' => 'top', '-' => 'middle', '~' => 'bottom' }[Regexp.last_match(1)]};" if marks =~ /([\^~-])/
      style << Regexp.last_match(1).strip.sub(/;?\z/, ';') if attributes =~ /\{([^}]*)\}/
      {
        tag: header ? 'th' : 'td',
        colspan: attributes[/\\(\d+)/, 1],
        rowspan: attributes[%r{/(\d+)}, 1],
        style: style.join(' '),
        segments: cell_segments(content.strip),
      }
    end
  end

  # A cell's text, with collapsed sections as <details>.
  def cell_segments(content)
    segments = []
    rest = content
    while (match = rest.match(/\{\{collapse(?:\(([^\n]*)\))?[ \t]*\n(.*?)\n?\s*\}\}/m))
      segments << match.pre_match unless match.pre_match.strip.empty?
      segments << { html: "<details><summary>#{collapse_label(match[1])}</summary>" }
      segments << match[2]
      segments << { html: '</details>' }
      rest = match.post_match
    end
    segments << rest unless rest.strip.empty?
    segments
  end

  def cells_to_html(texts)
    return [] if texts.empty?

    separator = 'RGCELLSEP'
    html, status = Open3.capture2('pandoc', '-f', 'textile', '-t', 'html', '--wrap=none', stdin_data: texts.join("\n\n#{separator}\n\n"))
    abort 'pandoc failed on a table' unless status.success?

    parts = html.force_encoding(Encoding::UTF_8).split(%r{\s*<p>#{separator}</p>\s*})
    abort 'a table cell was not converted' unless parts.size == texts.size

    parts.map { |part| yield(part.strip.sub(%r{\A<p>(.*)</p>\z}m, '\1').gsub("\n", '')) }
  end

  def table_html(rows, style = nil)
    head = rows.first.all? { |cell| cell[:tag] == 'th' } ? [rows.first] : []
    body = rows.drop(head.size)
    render = lambda do |cell|
      attributes = +''
      attributes << %( colspan="#{cell[:colspan]}") if cell[:colspan]
      attributes << %( rowspan="#{cell[:rowspan]}") if cell[:rowspan]
      attributes << %( style="#{cell[:style]}") unless cell[:style].empty?
      "<#{cell[:tag]}#{attributes}>#{cell[:html]}</#{cell[:tag]}>"
    end
    section = ->(tag, list) { list.empty? ? [] : ["<#{tag}>", *list.flat_map { |row| ['<tr>', *row.map(&render), '</tr>'] }, "</#{tag}>"] }
    table = style.to_s.strip.empty? ? '<table>' : %(<table style="#{CGI.escapeHTML(style.strip.sub(/;?\z/, ';'))}">)
    [table, *section.call('thead', head), *section.call('tbody', body), '</table>'].join("\n")
  end
end
