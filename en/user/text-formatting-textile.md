---
source: RedmineTextFormattingTextile
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineTextFormattingTextile
source_version: 19
source_updated_on: '2025-10-30T19:33:18Z'
---

# Textile formatting

Below is **Textile** formatting. For **Markdown** formatting see [RedmineTextFormattingMarkdown](text-formatting-markdown.md).\
For limitations of current Textile support see \[#6269](https://www.redmine.org/issues/6269), \[#10078](https://www.redmine.org/issues/10078) (Definition Lists).

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

    <code>* *bold*
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
    * <notextile><pre>*some lines*      some "link":http://www.redmine.org

</notextile>

\* \<pre\>\<notextile\>**some lines** some [link](http://www.redmine.org</pre></notextile>)\
</code>

</pre>

displays:

\* **bold**\
\* *italic*\
\* ***bold italic***\
\* <u>underline</u>\
\* ~~strike-through~~\
\* Plain <sup>superscript</sup>\
\* Plain <sub>subscript</sub>\
\* `inline monospace`\
\* normal **bold** *italic* normal;E=mc <sup>2</sup>\
\* normal**bold***italic*normal;E=mc<sup>2</sup>\
\* Escaping: \*bold\* \_italic\_ @inlinemono@       Alternative using HTML-codes: \*bold\* \_italic\_ @inlinemono@\
\*

    *some lines*      some "link":http://www.redmine.org

\
\*

    <notextile></notextile>*some lines*      some "link":http://www.redmine.org

### Color

    <code><notextile>* %{color:red}red% %{color:green}green% %{color:yellow}yellow% %{color:#82B6E1}blue'ish%
    * %{color:red}red%<notextile></notextile>%{color:green}green%<notextile></notextile>%{color:yellow}yellow%<notextile></notextile>%{color:#82B6E1}blue'ish%
    * %{background:lightgreen}Lightgreen Background% %{background:yellow}Yellow Background%
    * %{background:lightgreen}Lightgreen Background%<notextile></notextile>%{background:yellow}Yellow Background%
    </notextile></code>

displays:

\* <span style="color:red;">red</span> <span style="color:green;">green</span> <span style="color:yellow;">yellow</span> <span style="color:#82B6E1;">blue’ish</span>\
\* %{color:red}red%%{color:green}green%%{color:yellow}yellow%<span style="color:#82B6E1;">blue’ish</span>\
\* <span style="background:lightgreen;">Lightgreen Background</span> <span style="background:yellow;">Yellow Background</span>\
\* %{background:lightgreen}Lightgreen Background%<span style="background:yellow;">Yellow Background</span>

### Inline images

- **!image_url!** displays an image located at image_url (textile syntax)
- **!\>image_url!** right floating image
- **!image_url(Image title)!** displays an image with an alt/title attribute
- **!image_url!:URL** displays an image located at image_url with link URL added

If you have an image attached to your wiki page, it can be displayed inline using its filename: **!attached_image.png!**

You can also apply a CSS style to the image in the same ways as styling SPANs. The code **!{width: 100%}attached_image.png!** will make the image adjusts to the parent’s width.

### Headings

    <code>h1. Heading

    h2. Subheading

    h3. Subheading
    </code>

Redmine assigns an anchor to each of those headings thus you can link to them with “\#Heading”, “\#Subheading” and so forth.

### Paragraphs

    <code>p. left aligned

    p(. left ident 1em

    p((. left ident 2em
    as well as for following lines

    right aligned

    p)))>. right ident 3em

    This is centered paragraph.
    </code>

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

     <pre>*Your text won't become bold*

</pre>

displays:

     *Your text won't become bold* 

### Blockquotes

Start the paragraph with **bq.**:

    <code>bq. Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    To go live, all you need to add is a database and a web server.
    </code>

displays:

> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
> To go live, all you need to add is a database and a web server.

You can also use \> at the beginning of each line and stack them for nested quotes:

    >> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    >> To go live, all you need to add is a database and a web server.
    > Great!

displays:

\>\> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
\>\> To go live, all you need to add is a database and a web server.\
\> Great!

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
<th style="text-align: center;">UserID</th>
<th style="text-align: left;">Name</th>
<th style="text-align: center;">Group</th>
<th style="text-align: right;">attribute list</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">Starting with</td>
<td style="text-align: left;">a</td>
<td style="text-align: center;">simple</td>
<td style="text-align: right;">row</td>
</tr>
<tr>
<td style="text-align: center;">IT</td>
<td style="text-align: left;">align left</td>
<td style="text-align: center;"></td>
<td style="text-align: right;"></td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: left;">Artur Pirozhkov</td>
<td style="text-align: center;">Users</td>
<td style="text-align: right;">align right</td>
</tr>
<tr>
<td style="text-align: center;">2</td>
<td style="text-align: left;">Vasya Rogov</td>
<td style="text-align: center;">center</td>
<td style="text-align: right;"></td>
</tr>
<tr>
<td style="text-align: center;">3</td>
<td style="text-align: left;">John Smith</td>
<td style="text-align: center;">Admin<br />
(root)</td>
<td style="text-align: right;">^. valign top</td>
</tr>
<tr>
<td style="text-align: center;">4</td>
<td style="text-align: left;">-</td>
<td style="text-align: center;">Nobody<br />
(anonymous)</td>
<td style="text-align: right;">~. valign bottom</td>
</tr>
</tbody>
</table>

If you want to include pipe characters inside your table (e.g. for Wiki links), you need to prevent textile from interpreting them:

| Input | Output |  |  |
|----|----|----|----|
| \*<notextile><notextile> | </notextile></notextile>\* | <notextile> | </notextile> |

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
| .        | 4   | Control sequence terminator        |

### Table of content

    <code> => left aligned toc
     => right aligned toc
    </code>

Please keep in mind, that the toc-tag needs an empty line above and underneath it and no other text before and after it.

Example:

    <code>
    h1. headLineOne

    h2. something

    h2. something more
    </code>

### Footnotes

Marker:

    This is a first word[1] with a footnote.

    This is a second word[2] with a footnote.

**Note:** Marker directly attached to word (no space, no dot or any thing else in between).

Definition:

    fn1. Footnote for the first word

    *Note:* Each definition on its own line anywhere within the document. Empty lines between definitions.

    displays:

    This is a first word[1] with a footnote.

    This is a second word[2] with a footnote.

    h2. Macros

    Redmine includes a macros system that lets you add custom functions to insert dynamic content in formatted text. You can learn about writing your own macros in [RedmineMacros](macros.md). Redmine also includes a few builtin macros:

    {{macro_list}}

    h2. Code highlighting

    Default code highlightment relies on "Rouge":http://rouge.jneen.net/, a syntax highlighting library written in pure Ruby. It supports many commonly used languages such as *c*, *cpp* (c++), *csharp* (c#, cs), *css*, *diff* (patch, udiff), *go* (golang), *groovy*, *html*, *java*, *javascript* (js), *kotlin*, *objective_c* (objc), *perl* (pl), *php*, *python* (py), *r*, *ruby* (rb), *sass*, *scala*, *shell* (bash, zsh, ksh, sh), *sql*, *swift*, *xml* and *yaml* (yml) languages, where the names inside parentheses are aliases. Please refer to [RedmineCodeHighlightingLanguages](code-highlighting-languages.md) for the full list of supported languages.

    You can highlight code in your wiki page using this syntax:

    <pre><code><pre><code class="ruby">
      Place your code here.
    </code>

\
</code>

</pre>

Example:

    <code class="ruby">
    # The Greeter class
    class Greeter
      def initialize(name)
        @name = name.capitalize
      end

      def salute
        puts "Hello #{@name}!"
      end
    end
    </code>

## Styling text using CSS

Textile can style text using CSS. Examples as follows:

    Three primary colors of light are %{color: #f00}red%, %{color: #0f0}green% and %{color: #00f}blue%.

    p{border: solid 1px [#000](https://www.redmine.org/issues/000); padding: 0.5em;}. The quick brown fox jumps over the lazy dog.

    table{width: 100%}.
    |={width: 30%; background-color: #aaf;}. column 1 |={width: 70%}. column 2 |

displays:

Three primary colors of light are %{color: \#f00}red%, <span style="color: #0f0;">green</span> and %{color: \#00f}blue%.

<div style="border: solid 1px [#000](https://www.redmine.org/issues/000); padding: 0.5em;;">

The quick brown fox jumps over the lazy dog.

</div>

|          |          |
|:--------:|:--------:|
| column 1 | column 2 |

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
