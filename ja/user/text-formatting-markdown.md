---
source: RedmineTextFormattingMarkdown
translated_from_version: 32
---

# Markdown

ここでは **Markdown** の書式を説明します。**Textile** の書式は、[Textile](text-formatting-textile.md) を参照してください。\
HTML タグを使えます。出力はサニタイズされ、安全な HTML の要素、属性、CSS プロパティだけが残ります。現在の **Markdown** の書式のそのほかの制限については、[#16373](https://www.redmine.org/issues/16373) と [#21443](https://www.redmine.org/issues/21443) を参照してください。

## リンク

### Redmine のリンク

[Redmine のリンク](text-formatting-redmine-links.md)

### 外部リンク

URL(http、https、ftp、ftps) は、自動でクリックできるリンクになります。

- **http://www.redmine.org** — Redmine の Web サイトへの外部リンク: http://www.redmine.org

URL とは別のテキストをリンクに使うこともできます。

- **\[Redmine web site\](http://www.redmine.org)** — 別のテキストを使った外部リンク: [Redmine web site](http://www.redmine.org)
- **\[\![Redmine web site\](http://www.redmine.org/attachments/7069/Redmine_logo.png)\](http://www.redmine.org)** — URL にリンクする、タイトル付きの外部の画像:

[![Redmine web site](../../images/RedmineTextFormattingMarkdown/Redmine_logo.png "Redmine web site")](http://www.redmine.org)

### メールアドレス

メールアドレスは、自動でクリックできるリンクになります。

- **someone@foo.bar** — メールアドレスへのリンク: someone@foo.bar
- **\[Email someone\](mailto:someone@foo.bar)** — 別のテキストを使ったメールのリンク: [Email someone](mailto:someone@foo.bar)

メールのリンクには、さらに細かい指定を追加できます。デフォルトの件名、デフォルトの本文、CC を指定できます。これらの欄の空白は、コード %20 に置き換える必要があります。

- **\[Email webmaster and admin\](mailto:webmaster@foo.bar?cc=admin@foo.bar)** — webmaster 宛てで admin を CC に入れたメール: [Email webmaster and admin](mailto:webmaster@foo.bar?cc=admin@foo.bar)
- **\[Email someone for help\](mailto:someone@foo.bar?subject=Website%20Help)** — 件名が「Website Help」のメールのリンク: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help)
- **\[Email someone for help\](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)** — 件名が「Website Help」で、デフォルトの本文の入ったメールのリンク: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)

## テキスト書式

見出し、太字、テーブル、リストなどの書式には、Redmine は [Markdown の構文](http://en.wikipedia.org/wiki/Markdown)に対応しています。これらの機能の使い方は、http://daringfireball.net/projects/markdown/syntax, http://agea.github.io/tutorial.md/, http://stackoverflow.com/editing-help を参照してください。以下にいくつか例を示しますが、エンジンはこれよりはるかに多くのことができます。変換については [Pandoc](http://pandoc.org) を参照してください。[commonmarker](https://github.com/gjtorikian/commonmarker) の gem による CommonMark Markdown (GitHub Flavored) のフォーマッターを使っています。

### 頭字語

Markdown では使えません。

### フォントスタイル

```text
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
```

表示:

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

**注:** 上の HTML タグ (\<strong\>、\<em\>、\<ins\>、\<del\>、\<sup\>、\<sub\>) は、CommonMark Markdown のフォーマッターで使えます。パッチは不要です。

### 色

```text
<notextile>* <span style="color:red">red</span> <span style="color:green">green</span> <span style="color:yellow">yellow</span> <span style="color:#82B6E1">blue'ish</span>
* <span style="color:red">red</span><span style="color:green">green</span><span style="color:yellow">yellow</span><span style="color:#82B6E1">blue'ish</span>
* <span style="background-color:lightgreen">Lightgreen Background</span> <span style="background-color:yellow">Yellow Background</span>
* <span style="background-color:lightgreen">Lightgreen Background</span><span style="background-color:yellow">Yellow Background</span>
</notextile>
```

表示:

- <span style="color:red">red</span> <span style="color:green">green</span> <span style="color:yellow">yellow</span> <span style="color:#82B6E1">blue’ish</span>
- <span style="color:red">red</span><span style="color:green">green</span><span style="color:yellow">yellow</span><span style="color:#82B6E1">blue’ish</span>
- <span style="background:lightgreen">Lightgreen Background</span> <span style="background:yellow">Yellow Background</span>
- <span style="background:lightgreen">Lightgreen Background</span><span style="background:yellow">Yellow Background</span>

**注:** HTML タグ (\<span\>) は、CommonMark Markdown のフォーマッターで使えます。`style` 属性に指定できるのは許可された CSS プロパティだけで、`color` と `background-color` はその中に含まれます。パッチは不要です。

### インライン画像

- **\*\*** は、image_url にある画像を表示します (Textile の構文)
- **\![alt text\](image_url “optional title”)** は、alt 属性と title 属性の付いた画像を表示します
- **\[\*\*\](URL)** は、image_url にある画像を、URL へのリンクを付けて表示します

Wikiページに添付した画像は、ファイル名を使ってインラインで表示できます: **\*\***。

この文書を書いた時点では、Markdown には画像のサイズを指定する構文がありません。サイズの指定が必要な場合は、通常の HTML の \<img\> タグを使えます。

- \<img style=”float:right” src=”URL”/\>
- \<img style=”width:100%” src=”attached_image.png”/\>

**注:** HTML タグ (\<img\>) は、CommonMark Markdown のフォーマッターで使えます。`style` 属性には、`float` や `width` など、許可された CSS プロパティを指定できます。パッチは不要です。

### 見出し

```text
# Heading

## Subheading

### Subheading

or

Heading
=======

Subheading
----------
```

Redmine はこれらの見出しにそれぞれアンカーを付けるため、「\#Heading」、「\#Subheading」などでリンクできます。

### 段落

Markdown では、段落の配置を指定できません。必要な場合は \<div\> タグを使います。

```text
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
```

表示:

left aligned

p(. left ident 1em

p((. left ident 2em\
as well as for following lines

right aligned

p)))\>. right ident 3em

This is centered paragraph.

**注:** HTML タグ (\<div\>) は、CommonMark Markdown のフォーマッターで使えます。`style` 属性には、`padding-left`、`padding-right`、`text-align` など、許可された CSS プロパティを指定できます。パッチは不要です。

### 水平線

`----`

表示:

------------------------------------------------------------------------

### 整形済みテキスト

 ```text
 <pre>**Your text won't become bold**</pre>
 ```

表示:

```text
**Your text won't become bold**
```

### 引用

各行の先頭に \> を付けると引用になります。\> を重ねると、入れ子の引用になります。

```text
>> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
>> To go live, all you need to add is a database and a web server.
> Great!
```

表示:

<blockquote><blockquote>

Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
To go live, all you need to add is a database and a web server.

</blockquote>

Great!

</blockquote>

### 順不同リスト

順不同リストでは、アスタリスク (`*`)、プラス (`+`)、ハイフン (`-`) を行頭記号に使います。

```text
* Item 1
* Item 2
  * Item 21 (two spaces indentation)
  * Item 22
* Item 3
```

表示:

- Item 1
- Item 2
  - Item 21
  - Item 22
- Item 3

### 番号つきリスト

番号つきリストでは、数字とピリオドを使います。

```text
1. Item 1
3. Item 2
2. Item 3
  1. Item 3.1 (two spaces)
  1. Item 3.2
```

表示:

1.  Item 1
2.  Item 2
3.  Item 3
    1.  Item 3.1
    2.  Item 3.2

リストに付ける実際の数字は、出力に影響しません。

### タスクリスト

タスクリストの項目は、次の common_mark の書式で追加できます。

 ```text
 * [ ] Task title
 ```

ツールバーの「タスクリスト」のアイコンをクリックしても追加できます。

今のところ、項目にチェックを付けるには「編集」を使う必要があります。近いうちに、チェックボックスをクリックしてチェックを付けられるようにする予定です。

### テーブル

```text
|UserID (align right)|Name (align left)|Group (align center)|
|-------------------:|:----------------|:------------------:|
|2                   |John Smith       |                    |
|3                   |Dave Lopper      |A Team              |
|4                   |Robert Hill      |B Team              |
```

表示 (連続する空白は 1 つにまとめられます):

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

### 目次

```text
{{toc}} => left aligned toc
{{>toc}} => right aligned toc
```

toc のタグの上と下には空行が必要で、タグの前後にはほかのテキストを置けないことに注意してください。

例:

```text
h1. headLineOne

h2. something

{{toc}}

h2. something more
```

### 脚注

脚注は、参照形式のリンクとほぼ同じように働きます。脚注は、テキストの横に付けるマーカーと、文書の中の任意の場所に 1 行で書く脚注の定義からなります。マーカーの例は `This is a sentence.[^1]`、脚注の定義の例は `[^1]: This is a footnote.` です。

## マクロ

Redmine にはマクロの仕組みがあり、書式付きテキストに動的な内容を挿入する独自の機能を追加できます。独自のマクロの書き方は、[マクロ](macros.md)を参照してください。Redmine には、いくつかの組み込みのマクロもあります。

- `hello_world`: サンプルのマクロです。
- `macro_list`: 使用できるすべてのマクロの一覧を、説明があれば説明とともに表示します。
- `child_pages`: 子ページの一覧を表示します。引数がなければ、今の Wiki ページの子ページを表示します。例:

  ```text
  {{child_pages}} -- can be used from a wiki page only
  {{child_pages(depth=2)}} -- display 2 levels nesting only
  {{child_pages(Foo)}} -- lists all children of page Foo
  {{child_pages(Foo, parent=1)}} -- same as above with a link to page Foo
  ```

- `recent_pages`: 最近更新された Wiki ページの一覧を表示します。引数がなければ、過去 7 日間に更新されたページを表示します。例:

  ```text
  {{recent_pages}} -- displays pages updated within the last 7 days
  {{recent_pages(days=3)}} -- displays pages updated within the last 3 days
  {{recent_pages(limit=5)}} -- limits the maximum number of pages to display to 5
  {{recent_pages(time=true)}} -- displays pages updated within the last 7 days with updated time
  {{recent_pages(project=identifier)}} -- displays pages updated within the last 7 days from a specific project
  {{recent_pages(include_subprojects=true)}} -- includes pages from subprojects
  ```

- `include`: Wiki ページを挿入します。例:

  ```text
  {{include(Foo)}}
  {{include(projectname:Foo)}} -- to include a page of a specific project wiki
  ```

- `collapse`: 折りたたんだテキストのブロックを挿入します。例:

  ```text
  {{collapse
  This is a block of text that is collapsed by default.
  It can be expanded by clicking a link.
  }}

  {{collapse(View details...)
  With custom link text.
  }}
  ```

- `thumbnail`: 添付した画像の、クリックできるサムネイルを表示します。デフォルトのサイズは 200 ピクセルです。例:

  ```text
  {{thumbnail(image.png)}}
  {{thumbnail(image.png, size=300, title=Thumbnail)}} -- with custom title and size
  ```

- `issue`: 追加の情報を含むチケットへのリンクを表示します。例:

  ```text
  {{issue(123)}}                              -- Issue #123: Enhance macro capabilities
  {{issue(123, project=true)}}                -- Andromeda - Issue #123: Enhance macro capabilities
  {{issue(123, tracker=false)}}               -- #123: Enhance macro capabilities
  {{issue(123, subject=false, project=true)}} -- Andromeda - Issue #123
  ```

## コードハイライト

デフォルトのコードハイライトには、Ruby だけで書かれたシンタックスハイライトのライブラリ [Rouge](http://rouge.jneen.net/) を使っています。Rouge は、**c**, **cpp** (c++), **csharp** (c#, cs), **css**, **diff** (patch, udiff), **go** (golang), **groovy**, **html**, **java**, **javascript** (js), **kotlin**, **objective_c** (objc), **perl** (pl), **php**, **python** (py), **r**, **ruby** (rb), **sass**, **scala**, **shell** (bash, zsh, ksh, sh), **sql**, **swift**, **xml**, **yaml** (yml) など、よく使われる多くの言語に対応しています。かっこの中の名前は別名です。対応しているすべての言語は、[コードハイライトの対応言語](code-highlighting-languages.md)を参照してください。

Wikiページのコードは、次の構文でハイライトできます。

````text
``` ruby
Place your code here.
```
````

例:

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

## 翻訳

次の翻訳は、最新ではない場合があります。必要に応じて、英語の元の文書を参照してください。

- [Português Brasileiro](https://www.redmine.org/projects/redmine/wiki/BrRedmineWikiFormatting)
- [Русский](https://www.redmine.org/projects/redmine/wiki/RusRedmineTextFormatting)
- [French](https://www.redmine.org/projects/redmine/wiki/FrRedmineWikiFormatting)
- [Deutsch](https://www.redmine.org/projects/redmine/wiki/DeRedmineTextFormattingMarkdown)
- [Korean](https://www.redmine.org/projects/redmine/wiki/KoreanWikiFormatting)
- [Türkçe](https://www.redmine.org/projects/redmine/wiki/TurkishWikiFormatting)
- [繁體中文](https://www.redmine.org/projects/redmine/wiki/TraditionalChineseWikiFormatting)
- [简体中文](https://www.redmine.org/projects/redmine/wiki/SimplifiedChineseWikiFormatting)
