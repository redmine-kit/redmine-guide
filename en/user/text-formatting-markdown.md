---
source: RedmineTextFormattingMarkdown
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineTextFormattingMarkdown
source_version: 32
source_updated_on: '2023-09-29T10:49:32Z'
---

# Markdown formatting

Below is **Markdown** formatting. For **Textile** formatting see [Textile formatting](text-formatting-textile.md).\
Currently HTML tags are not allowed by default. See [#15520](https://www.redmine.org/issues/15520) and [#20497](https://www.redmine.org/issues/20497) for details. For other limitations of the current **Markdown** formatting see [#16373](https://www.redmine.org/issues/16373) and [#21443](https://www.redmine.org/issues/21443).

## Links

### Redmine links

[RedmineTextFormattingRedmineLinks](text-formatting-redmine-links.md)

### External links

URLs (http, https, ftp and ftps) are automatically turned into clickable links:

- **http://www.redmine.org** — External link to the redmine website: http://www.redmine.org

URLs can also use different text than the link itself:

- **\[Redmine web site\](http://www.redmine.org)** — External link with different text: [Redmine web site](http://www.redmine.org)
- **\[\*Redmine web site\*\](http://www.redmine.org)** — External image with a title that links to an URL:

[![Redmine web site](http://www.redmine.org/attachments/7069/Redmine_logo.png "Redmine web site")](http://www.redmine.org)

### Email addresses

Email addresses are automatically turned into clickable links:

- **someone@foo.bar** — Link to an email address: someone@foo.bar
- **\[Email someone\](mailto:someone@foo.bar)** — Email link with different text: [Email someone](mailto:someone@foo.bar)

More complex email instructions can be added to an email link. A default subject, default body and CC information can be defined. Note that spaces in any of these fields need to be replaced with the code %20.

- **\[Email webmaster and admin\](mailto:webmaster@foo.bar?cc=admin@foo.bar)** — Email to webmaster, CC admin: [Email webmaster and admin](mailto:webmaster@foo.bar?cc=admin@foo.bar)
- **\[Email someone for help\](mailto:someone@foo.bar?subject=Website%20Help)** — Email link with the subject “Website Help”: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help)
- **\[Email someone for help\](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)** — Email link with the subject “Website Help” and a default body: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)

## Text formatting

For things such as headlines, bold, tables, lists, Redmine supports [Markdown syntax](http://en.wikipedia.org/wiki/Markdown). See http://daringfireball.net/projects/markdown/syntax, http://agea.github.io/tutorial.md/, http://stackoverflow.com/editing-help for information on using any of these features. A few samples are included below, but the engine is capable of much more of that. For conversions see [Pandoc](http://pandoc.org). The [Redcarpet formatter](https://github.com/alminium/redmine_redcarpet_formatter) is used.

### Acronym

Not supported by Markdown

### Font style

    * **bold** __bold__
    * *italic* _italic_
    * ***bold italic*** ___bold italic___
    * <ins>underline</ins>
    * <del>strike through</del>
    * Plain <sup>superscript</sup>
    * Plain <sub>subscript</sub>
    * `inline monospace`
    * normal **bold** _italic_ normal;E=mc<sup>2</sup>
    * normal<strong>bold</strong><em>italic</em>normal;E=mc<sup>2</sup>
    * Escaping: \*\*bold\*\* \_italic\_ \`inlinemono\`
    * <notextile><pre>**some lines**      some [link](http://www.redmine.org)</pre></notextile>
    * <notextile><pre>\*\*some lines\*\*      some \[link](http\://www\.redmine\.org)</pre></notextile>

displays:

- **bold** **bold**
- *italic* *italic*
- ***bold italic*** ***bold italic***
- <u>underline</u>
- ~~strike-through~~
- Plain <sup>superscript</sup>
- Plain <sub>subscript</sub>
- `inline monospace`
- normal **bold** *italic* normal;E=mc<sup>2</sup>
- normal**bold***italic*normal;E=mc<sup>2</sup>
- Escaping: \*\*bold\*\* \_italic\_ \`inlinemono\`
- `<notextile></notextile>*some lines*      some "link":http://www.redmine.org`
- `**some lines**      some [link](http://www.redmine.org)`

**Note:** HTML tags need to be allowed to use the HTML tags (\<strong\>, \<em\>, \<ins\>, \<del\>, \<sup\>, \<sub\>). See [#15520](https://www.redmine.org/issues/15520)-16 and [#15520](https://www.redmine.org/issues/15520)-17 for details.\
More explicitly, you need to patch redmine, as explained in [this post](https://www.redmine.org/boards/2/topics/56096?r=57052#message-57052)

### Color

    <notextile>* <span style="color:red">red</span> <span style="color:green">green</span> <span style="color:yellow">yellow</span> <span style="color:#82B6E1">blue'ish</span>
    * <span style="color:red">red</span><span style="color:green">green</span><span style="color:yellow">yellow</span><span style="color:#82B6E1">blue'ish</span>
    * <span style="background-color:lightgreen">Lightgreen Background</span> <span style="background-color:yellow">Yellow Background</span>
    * <span style="background-color:lightgreen">Lightgreen Background</span><span style="background-color:yellow">Yellow Background</span>
    </notextile>

displays:

- <span style="color:red">red</span> <span style="color:green">green</span> <span style="color:yellow">yellow</span> <span style="color:#82B6E1">blue’ish</span>
- <span style="color:red">red</span><span style="color:green">green</span><span style="color:yellow">yellow</span><span style="color:#82B6E1">blue’ish</span>
- <span style="background:lightgreen">Lightgreen Background</span> <span style="background:yellow">Yellow Background</span>
- <span style="background:lightgreen">Lightgreen Background</span><span style="background:yellow">Yellow Background</span>

**Note:** HTML tags need to be allowed to use the HTML tag (\<span\>). See [#15520](https://www.redmine.org/issues/15520)-16 and [#15520](https://www.redmine.org/issues/15520)-17 for details.\
More explicitly, you need to patch redmine, as explained in [this post](https://www.redmine.org/boards/2/topics/56096?r=57052#message-57052)

### Inline images

- **\*\*** displays an image located at image_url (textile syntax)
- **\![alt text\](image_url “optional title”)** displays an image with an alt/title attribute
- **\[\*\*\](URL)** displays an image located at image_url with link URL added

If you have an image attached to your wiki page, it can be displayed inline using its filename: **\*\***.

As of this writing, Markdown has no syntax for specifying the dimensions of an image; if this is important to you, you can use regular HTML \<img\> tags.

- \<img style=”float:right” src=”URL”/\>
- \<img style=”width:100%” src=”attached_image.png”/\>

**Note:** HTML tags need to be allowed to use the HTML tag (\<img\>). See [#15520](https://www.redmine.org/issues/15520)-16 and [#15520](https://www.redmine.org/issues/15520)-17 for details.\
More explicitly, you need to patch redmine, as explained in [this post](https://www.redmine.org/boards/2/topics/56096?r=57052#message-57052)

### Headings

    # Heading

    ## Subheading

    ### Subheading

    or

    Heading
    =======

    Subheading
    ----------

Redmine assigns an anchor to each of those headings thus you can link to them with “\#Heading”, “\#Subheading” and so forth.

### Paragraphs

Markdown does not support alignment of a paragraph. Use \<div\> tags if you need it.

    left aligned
    <div style="padding-left:1em;">
    left ident 1em
    </div>

    <div style="padding-left:2em;">
    left ident 2em
    as well as for following lines
    </div>

    <div style="text-align:right;">
    right aligned
    </div>

    <div style="padding-right:3em;text-align:right;">
    right ident 3em
    </div>

    <div style="text-align:center;">
    This is centered paragraph.
    </div>

displays;

left aligned

p(. left ident 1em

p((. left ident 2em\
as well as for following lines

right aligned

p)))\>. right ident 3em

This is centered paragraph.

**Note:** HTML tags need to be allowed to use the HTML tags (\<div\>). See [#15520](https://www.redmine.org/issues/15520)-16 and [#15520](https://www.redmine.org/issues/15520)-17 for details.\
More explicitly, you need to patch redmine, as explained in [this post](https://www.redmine.org/boards/2/topics/56096?r=57052#message-57052)

### Horizontal rule

`----`

displays:

------------------------------------------------------------------------

### Preformatted Text

     <pre>**Your text won't become bold**</pre>

displays:

    **Your text won't become bold**

### Blockquotes

You can use \> at the beginning of each line and stack them for nested quotes:

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

Unordered lists use asterisks (`*`), pluses (`+`), and hyphens (`-`) as list markers

    * Item 1
    * Item 2
      * Item 21 (two spaces indentation)
      * Item 22
    * Item 3

displays:

- Item 1
- Item 2
  - Item 21
  - Item 22
- Item 3

### Ordered lists

Ordered lists use numbers followed by periods.

    1. Item 1
    3. Item 2
    2. Item 3
      1. Item 3.1 (two spaces)
      1. Item 3.2

displays:

1.  Item 1
2.  Item 2
3.  Item 3
    1.  Item 3.1
    2.  Item 3.2

Note that the actual numbers you use to mark the list have no effect on the output.

### Tasklists

You can add task list items using the common_mark format

     * [ ] Task title

or by clicking the “Task list” icon from the toolbar.

For now, to check the items, you need to use the Edit feature, we will try to allow this by clicking on the checkbox in the near future.

### Tables

    |UserID (align right)|Name (align left)|Group (align center)|
    |-------------------:|:----------------|:------------------:|
    |2                   |John Smith       |                    |
    |3                   |Dave Lopper      |A Team              |
    |4                   |Robert Hill      |B Team              |

displays (all multiple spaces are replaced by 1 space):

<table>
<thead>
<tr>
<th style="text-align: right;">UserID (align right)</th>
<th style="text-align: left;">Name (align left)</th>
<th style="text-align: center;">Group (align center)</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: right;">2</td>
<td style="text-align: left;">John Smith</td>
<td></td>
</tr>
<tr>
<td style="text-align: right;">3</td>
<td style="text-align: left;">Dave Lopper</td>
<th style="text-align: center;">A Team</th>
</tr>
<tr>
<td style="text-align: right;">4</td>
<td style="text-align: left;">Robert Hill</td>
<th style="text-align: center;">B Team</th>
</tr>
</tbody>
</table>

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

A footnote works very much like a reference-style link: it consists of a marker next to the text, e.g. `This is a sentence.[^1]` and a footnote definition on its own line anywhere within the document, e.g. `[^1]: This is a footnote.`

## Macros

Redmine includes a macros system that lets you add custom functions to insert dynamic content in formatted text. You can learn about writing your own macros in [RedmineMacros](macros.md). Redmine also includes a few builtin macros:

{{macro_list}}

## Code highlighting

Default code highlightment relies on [Rouge](http://rouge.jneen.net/), a syntax highlighting library written in pure Ruby. It supports many commonly used languages such as **c**, **cpp** (c++), **csharp** (c#, cs), **css**, **diff** (patch, udiff), **go** (golang), **groovy**, **html**, **java**, **javascript** (js), **kotlin**, **objective_c** (objc), **perl** (pl), **php**, **python** (py), **r**, **ruby** (rb), **sass**, **scala**, **shell** (bash, zsh, ksh, sh), **sql**, **swift**, **xml** and **yaml** (yml) languages, where the names inside parentheses are aliases. Please refer to [RedmineCodeHighlightingLanguages](code-highlighting-languages.md) for the full list of supported languages.

You can highlight code in your wiki page using this syntax:

    ``` ruby
    Place your code here.
    ```

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

## Translation

Note that the following translations may not be up to date. Please refer to the original english documentation if needed.

- [Português Brasileiro](https://www.redmine.org/projects/redmine/wiki/BrRedmineWikiFormatting)
- [Русский](https://www.redmine.org/projects/redmine/wiki/RusRedmineTextFormatting)
- [French](https://www.redmine.org/projects/redmine/wiki/FrRedmineWikiFormatting)
- [Deutsch](https://www.redmine.org/projects/redmine/wiki/DeRedmineTextFormattingMarkdown)
- [Korean](https://www.redmine.org/projects/redmine/wiki/KoreanWikiFormatting)
- [Türkçe](https://www.redmine.org/projects/redmine/wiki/TurkishWikiFormatting)
- [繁體中文](https://www.redmine.org/projects/redmine/wiki/TraditionalChineseWikiFormatting)
- [简体中文](https://www.redmine.org/projects/redmine/wiki/SimplifiedChineseWikiFormatting)
