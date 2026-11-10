---
source: RedmineTextFormattingTextile
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineTextFormattingTextile
source_version: 19
source_updated_on: '2025-10-30T19:33:18Z'
updated_for: 7.0.3
---

# Textile formatting

Below is **Textile** formatting. For **Markdown** formatting see [RedmineTextFormattingMarkdown](text-formatting-markdown.md).\
For limitations of current Textile support see [#6269](https://www.redmine.org/issues/6269), [#10078](https://www.redmine.org/issues/10078) (Definition Lists).

## Links

### Redmine links

[RedmineTextFormattingRedmineLinks](text-formatting-redmine-links.md)

### External links

URLs (http, https, ftp and ftps) are automatically turned into clickable links:

- **http://www.redmine.org** — External link to the redmine website: http://www.redmine.org

URLs can also use different text than the link itself:

- **“Redmine web site”:http://www.redmine.org** — External link with different text: [Redmine web site](http://www.redmine.org)
- **[![Redmine web site](http://www.redmine.org/attachments/7069/Redmine_logo.png "Redmine web site")](http://www.redmine.org)** — External image with a title that links to an URL:

[![Redmine web site](http://www.redmine.org/attachments/7069/Redmine_logo.png "Redmine web site")](http://www.redmine.org)

File URI can be used to link UNC path:

- **“\\server\share\$”:file://///server/share%24** — File URI showing UNC path: [\\server\share\$](file://///server/share%24)\
  You should [URL Encodings](http://www.w3schools.com/tags/ref_urlencode.asp) for special characters like empty space, \$, á, é, í, ó, ú, etc.

### Email addresses

Email addresses are automatically turned into clickable links:

- **someone@foo.bar** — Link to an email address: someone@foo.bar
- **“Email someone”:mailto:someone@foo.bar** — Email link with different text: [Email someone](mailto:someone@foo.bar)

More complex email instructions can be added to an email link. A default subject, default body and CC information can be defined. Note that spaces in any of these fields need to be replaced with the code %20.

- **“Email webmaster and admin”:mailto:webmaster@foo.bar?cc=admin@foo.bar** — Email to webmaster, CC admin: [Email webmaster and admin](mailto:webmaster@foo.bar?cc=admin@foo.bar)
- **“Email someone for help”:mailto:someone@foo.bar?subject=Website%20Help** — Email link with the subject “Website Help”: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help)
- **“Email someone for help”:mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20** — Email link with the subject “Website Help” and a default body: [My problem is](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)

## Text formatting

For things such as headlines, bold, tables, lists, Redmine supports [Textile syntax](http://en.wikipedia.org/wiki/Textile_%28markup_language%29). See http://redcloth.org/hobix.com/textile/ for information on using any of these features. A few samples are included below, but the engine is capable of much more of that.

### Acronym

    JPL(Jean-Philippe Lang)

displays:

JPL (Jean-Philippe Lang)

### Font style

    * *bold*
    * _italic_
    * *_bold italic_*
    * +underline+
    * -strike-through-
    * Plain ^superscript^
    * Plain ~subscript~
    * @inline monospace@
    * <notextile>normal *bold* _italic_ normal;E=mc ^2^</notextile>
    * <notextile>normal<notextile></notextile>*bold*<notextile></notextile>_italic_<notextile></notextile>normal;E=mc<notextile></notextile>^2^</notextile>
    * <notextile>Escaping: <notextile>*bold* _italic_ @inlinemono@</notextile> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alternative using HTML-codes: &#42;bold&#42; &#95;italic&#95; &#64;inlinemono&#64;</notextile>
    * <notextile><pre>*some lines*      some "link":http://www.redmine.org</pre></notextile>
    * <notextile><pre><notextile></notextile>*some lines*      some "link":http://www.redmine.org</pre></notextile>

displays:

- **bold**
- *italic*
- ***bold italic***
- <u>underline</u>
- ~~strike-through~~
- Plain <sup>superscript</sup>
- Plain <sub>subscript</sub>
- `inline monospace`
- normal **bold** *italic* normal;E=mc <sup>2</sup>
- normal**bold***italic*normal;E=mc<sup>2</sup>
- Escaping: \*bold\* \_italic\_ @inlinemono@       Alternative using HTML-codes: \*bold\* \_italic\_ @inlinemono@
- `*some lines*      some "link":http://www.redmine.org`
- `<notextile></notextile>*some lines*      some "link":http://www.redmine.org`

### Color

    <notextile>* %{color:red}red% %{color:green}green% %{color:yellow}yellow% %{color:#82B6E1}blue'ish%
    * %{color:red}red%<notextile></notextile>%{color:green}green%<notextile></notextile>%{color:yellow}yellow%<notextile></notextile>%{color:#82B6E1}blue'ish%
    * %{background:lightgreen}Lightgreen Background% %{background:yellow}Yellow Background%
    * %{background:lightgreen}Lightgreen Background%<notextile></notextile>%{background:yellow}Yellow Background%
    </notextile>

displays:

- <span style="color:red">red</span> <span style="color:green">green</span> <span style="color:yellow">yellow</span> <span style="color:#82B6E1">blue’ish</span>
- <span style="color:red">red</span><span style="color:green">green</span><span style="color:yellow">yellow</span><span style="color:#82B6E1">blue’ish</span>
- <span style="background:lightgreen">Lightgreen Background</span> <span style="background:yellow">Yellow Background</span>
- <span style="background:lightgreen">Lightgreen Background</span><span style="background:yellow">Yellow Background</span>

### Inline images

- **!image_url!** displays an image located at image_url (textile syntax)
- **!\>image_url!** right floating image
- **!image_url(Image title)!** displays an image with an alt/title attribute
- **!image_url!:URL** displays an image located at image_url with link URL added

If you have an image attached to your wiki page, it can be displayed inline using its filename: **!attached_image.png!**

You can also apply a CSS style to the image in the same ways as styling SPANs. The code **!{width: 100%}attached_image.png!** will make the image adjusts to the parent’s width.

### Headings

    h1. Heading

    h2. Subheading

    h3. Subheading

Redmine assigns an anchor to each of those headings thus you can link to them with “\#Heading”, “\#Subheading” and so forth.

### Paragraphs

    p. left aligned

    p(. left ident 1em

    p((. left ident 2em
    as well as for following lines

    p>. right aligned

    p)))>. right ident 3em

    p=. This is centered paragraph.

displays;

left aligned

p(. left ident 1em

p((. left ident 2em\
as well as for following lines

right aligned

p)))\>. right ident 3em

This is centered paragraph.

### Horizontal rule

`----`

displays:

------------------------------------------------------------------------

### Preformatted Text

     <pre>*Your text won't become bold*</pre>

displays:

     *Your text won't become bold*

### Blockquotes

Start the paragraph with **bq.**:

    bq. Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    To go live, all you need to add is a database and a web server.

displays:

> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
> To go live, all you need to add is a database and a web server.

You can also use \> at the beginning of each line and stack them for nested quotes:

    >> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    >> To go live, all you need to add is a database and a web server.
    > Great!

displays:

<blockquote><blockquote>

Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
To go live, all you need to add is a database and a web server.

</blockquote>

Great!

</blockquote>

### Unordered lists

    * Item 1
    * Item 2
    ** Item 21
    ** Item 22
    * Item 3

displays:

- Item 1
- Item 2
  - Item 21
  - Item 22
- Item 3

### Ordered lists

    # Item 1
    # Item 2
    # Item 3
    ## Item 3.1
    ## Item 3.2

displays:

1.  Item 1
2.  Item 2
3.  Item 3
    1.  Item 3.1
    2.  Item 3.2

### Tables

    |_.UserID      |_.Name          |_.Group     |_. attribute list   |
    |Starting with | a              |   simple   |row                 |
    |\3=.IT                                      |<. align left       |
    |1             |Artur Pirozhkov |/2.Users    |>. align right      |
    |2             |Vasya Rogov     |=. center   |
    |3             |John Smith      |Admin
                                     (root)      |^. valign top       |
    |4             |-               |Nobody
                                     (anonymous) |~. valign bottom    |

displays (all multiple spaces are replaced by 1 space):

<table>
<thead>
<tr>
<th>UserID</th>
<th>Name</th>
<th>Group</th>
<th>attribute list</th>
</tr>
</thead>
<tbody>
<tr>
<td>Starting with</td>
<td>a</td>
<td>simple</td>
<td>row</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">IT</td>
<td style="text-align: left;">align left</td>
</tr>
<tr>
<td>1</td>
<td>Artur Pirozhkov</td>
<td rowspan="2">Users</td>
<td style="text-align: right;">align right</td>
</tr>
<tr>
<td>2</td>
<td>Vasya Rogov</td>
<td style="text-align: center;">center</td>
</tr>
<tr>
<td>3</td>
<td>John Smith</td>
<td>Admin<br />(root)</td>
<td style="vertical-align: top;">valign top</td>
</tr>
<tr>
<td>4</td>
<td>-</td>
<td>Nobody<br />(anonymous)</td>
<td style="vertical-align: bottom;">valign bottom</td>
</tr>
</tbody>
</table>

If you want to include pipe characters inside your table (e.g. for Wiki links), you need to prevent textile from interpreting them:

| Input        | Output   |
|--------------|----------|
| **\<notextile\>\|\</notextile\>** | \| |

If you want to specify the width of the table, you need to put **table{width:100%}.** just before your table definition:

    table{width:100%}.
    | This table will use
    all horizontal space |

This way the table will extend to the whole page width …

<table>
<tbody>
<tr>
<td>This table will use<br />
all horizontal space</td>
</tr>
</tbody>
</table>

… compared with the standard width:

<table>
<tbody>
<tr>
<td>This table will use<br />
only the required space</td>
</tr>
</tbody>
</table>

There must be a blank line before the **table** keyword, but after it (up to the table) there must be no blank lines or anything else.

#### Special table control sequences

Nothing can be placed between the cell delimiter pipeline character and the control sequences.\
The order of the table control sequences is fixed. If two order are equal then the precedence of the sequences is equal.\
If the table control sequences are used in the wrong order, they will not be interpreted.

| Sequence | Ord | Function                           |
|----------|-----|------------------------------------|
| \_       | 1   | Highlight the contents of the cell |
| \n       | 2   | Merge *n* cells horizontally       |
| /n       | 2   | Merge *n* cells vertically         |
| \<       | 3   | Allign text to left                |
| =        | 3   | Allign text to center              |
| \>       | 3   | Allign text to right               |
| ^        | 3   | Allign text to top                 |
| ~        | 3   | Allign text to bottom              |
| . | 4   | Control sequence terminator        |

### Table of content

    {{toc}} => left aligned toc
    {{>toc}} => right aligned toc

Please keep in mind, that the toc-tag needs an empty line above and underneath it and no other text before and after it.

Example:

    h1. headLineOne

    h2. something

    {{toc}}

    h2. something more

### Footnotes

Marker:

    This is a first word[1] with a footnote.

    This is a second word[2] with a footnote.

**Note:** Marker directly attached to word (no space, no dot or any thing else in between).

Definition:

    fn1. Footnote for the first word

    fn2. Footnote for the second word

**Note:** Each definition on its own line anywhere within the document. Empty lines between definitions.

displays:

This is a first word<sup>1</sup> with a footnote.

This is a second word<sup>2</sup> with a footnote.

<sup>1</sup> Footnote for the first word

<sup>2</sup> Footnote for the second word

## Macros

Redmine includes a macros system that lets you add custom functions to insert dynamic content in formatted text. You can learn about writing your own macros in [RedmineMacros](macros.md). Redmine also includes a few builtin macros:

- `hello_world`: Sample macro.
- `macro_list`: Displays a list of all available macros, including description if available.
- `child_pages`: Displays a list of child pages. With no argument, it displays the child pages of the current wiki page. Examples:

  ```
  {{child_pages}} -- can be used from a wiki page only
  {{child_pages(depth=2)}} -- display 2 levels nesting only
  {{child_pages(Foo)}} -- lists all children of page Foo
  {{child_pages(Foo, parent=1)}} -- same as above with a link to page Foo
  ```

- `recent_pages`: Displays a list of recently updated wiki pages. With no argument, it displays pages that have been updated within the last 7 days. Examples:

  ```
  {{recent_pages}} -- displays pages updated within the last 7 days
  {{recent_pages(days=3)}} -- displays pages updated within the last 3 days
  {{recent_pages(limit=5)}} -- limits the maximum number of pages to display to 5
  {{recent_pages(time=true)}} -- displays pages updated within the last 7 days with updated time
  {{recent_pages(project=identifier)}} -- displays pages updated within the last 7 days from a specific project
  {{recent_pages(include_subprojects=true)}} -- includes pages from subprojects
  ```

- `include`: Includes a wiki page. Examples:

  ```
  {{include(Foo)}}
  {{include(projectname:Foo)}} -- to include a page of a specific project wiki
  ```

- `collapse`: Inserts of collapsed block of text. Examples:

  ```
  {{collapse
  This is a block of text that is collapsed by default.
  It can be expanded by clicking a link.
  }}

  {{collapse(View details...)
  With custom link text.
  }}
  ```

- `thumbnail`: Displays a clickable thumbnail of an attached image. Default size is 200 pixels. Examples:

  ```
  {{thumbnail(image.png)}}
  {{thumbnail(image.png, size=300, title=Thumbnail)}} -- with custom title and size
  ```

- `issue`: Displays an issue link including additional information. Examples:

  ```
  {{issue(123)}}                              -- Issue #123: Enhance macro capabilities
  {{issue(123, project=true)}}                -- Andromeda - Issue #123: Enhance macro capabilities
  {{issue(123, tracker=false)}}               -- #123: Enhance macro capabilities
  {{issue(123, subject=false, project=true)}} -- Andromeda - Issue #123
  ```

## Code highlighting

Default code highlightment relies on [Rouge](http://rouge.jneen.net/), a syntax highlighting library written in pure Ruby. It supports many commonly used languages such as **c**, **cpp** (c++), **csharp** (c#, cs), **css**, **diff** (patch, udiff), **go** (golang), **groovy**, **html**, **java**, **javascript** (js), **kotlin**, **objective_c** (objc), **perl** (pl), **php**, **python** (py), **r**, **ruby** (rb), **sass**, **scala**, **shell** (bash, zsh, ksh, sh), **sql**, **swift**, **xml** and **yaml** (yml) languages, where the names inside parentheses are aliases. Please refer to [RedmineCodeHighlightingLanguages](code-highlighting-languages.md) for the full list of supported languages.

You can highlight code in your wiki page using this syntax:

    <pre><code class="ruby">
      Place your code here.
    </code></pre>

Example:

```ruby
# The Greeter class
class Greeter
  def initialize(name)
    @name = name.capitalize
  end

  def salute
    puts "Hello #{@name}!"
  end
end
```

## Styling text using CSS

Textile can style text using CSS. Examples as follows:

    Three primary colors of light are %{color: #f00}red%, %{color: #0f0}green% and %{color: #00f}blue%.

    p{border: solid 1px #000; padding: 0.5em;}. The quick brown fox jumps over the lazy dog.

    table{width: 100%}.
    |={width: 30%; background-color: #aaf;}. column 1 |={width: 70%}. column 2 |

displays:

Three primary colors of light are <span style="color: #f00">red</span>, <span style="color: #0f0">green</span> and <span style="color: #00f">blue</span>.

<div style="border: solid 1px #000; padding: 0.5em;;">

The quick brown fox jumps over the lazy dog.

</div>

<table style="width: 100%;">
<tbody>
<tr>
<td style="text-align: center; width: 30%; background-color: #aaf;">column 1</td>
<td style="text-align: center; width: 70%;">column 2</td>
</tr>
</tbody>
</table>

### Allowed CSS properties

Redmine allows the following properties. Other properties are not allowed for security reasons (see r2192).

- background
- background-\*
- border
- border-\*
- color
- float
- font
- font-\*
- height
- margin
- margin-\*
- max-height
- max-width
- min-height
- min-width
- padding
- padding-\*
- text
- text-\*
- width

## Translation

Note that the following translations may not be up to date. Please refer to the original english documentation if needed.

- [Português Brasileiro](https://www.redmine.org/projects/redmine/wiki/BrRedmineWikiFormatting)
- [Русский](https://www.redmine.org/projects/redmine/wiki/RusRedmineTextFormatting)
- [French](https://www.redmine.org/projects/redmine/wiki/FrRedmineWikiFormatting)
- [한글(Korean)](https://www.redmine.org/projects/redmine/wiki/KoreanWikiFormatting)
- [Türkçe](https://www.redmine.org/projects/redmine/wiki/TurkishWikiFormatting)
- [繁體中文](https://www.redmine.org/projects/redmine/wiki/TraditionalChineseWikiFormatting)
- [简体中文](https://www.redmine.org/projects/redmine/wiki/SimplifiedChineseWikiFormatting)
