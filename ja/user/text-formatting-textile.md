---
source: RedmineTextFormattingTextile
translated_from_version: 19
---

# Textile

ここでは **Textile** の書式を説明します。**Markdown** の書式は、[Markdown](text-formatting-markdown.md) を参照してください。\
現在の Textile への対応の制限については、\[#6269](https://www.redmine.org/issues/6269)、\[#10078](https://www.redmine.org/issues/10078)(定義リスト)を参照してください。

## リンク

### Redmine のリンク

[Redmine のリンク](text-formatting-redmine-links.md)

### 外部リンク

URL(http、https、ftp、ftps)は、自動でクリックできるリンクになります。

- **http://www.redmine.org** — Redmine の Web サイトへの外部リンク: http://www.redmine.org

URL とは別のテキストをリンクに使うこともできます。

- **“Redmine web site”:http://www.redmine.org** — 別のテキストを使った外部リンク: [Redmine web site](http://www.redmine.org)
- **[![Redmine web site](http://www.redmine.org/attachments/7069/Redmine_logo.png "Redmine web site")](http://www.redmine.org)** — URL にリンクする、タイトル付きの外部の画像:

[![Redmine web site](http://www.redmine.org/attachments/7069/Redmine_logo.png "Redmine web site")](http://www.redmine.org)

ファイル URI を使うと、UNC パスにリンクできます。

- **“\\server\share\$”:file://///server/share%24** — UNC パスを表示するファイル URI: [\\server\share\$](file://///server/share%24)\
  空白、\$、á、é、í、ó、ú などの特殊な文字は、[URL エンコード](http://www.w3schools.com/tags/ref_urlencode.asp)する必要があります。

### メールアドレス

メールアドレスは、自動でクリックできるリンクになります。

- **someone@foo.bar** — メールアドレスへのリンク: someone@foo.bar
- **“Email someone”:mailto:someone@foo.bar** — 別のテキストを使ったメールのリンク: [Email someone](mailto:someone@foo.bar)

メールのリンクには、さらに細かい指定を追加できます。デフォルトの件名、デフォルトの本文、CC を指定できます。これらの欄の空白は、コード %20 に置き換える必要があります。

- **“Email webmaster and admin”:mailto:webmaster@foo.bar?cc=admin@foo.bar** — webmaster 宛てで admin を CC に入れたメール: [Email webmaster and admin](mailto:webmaster@foo.bar?cc=admin@foo.bar)
- **“Email someone for help”:mailto:someone@foo.bar?subject=Website%20Help** — 件名が「Website Help」のメールのリンク: [Email someone for help](mailto:someone@foo.bar?subject=Website%20Help)
- **“Email someone for help”:mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20** — 件名が「Website Help」で、デフォルトの本文の入ったメールのリンク: [My problem is](mailto:someone@foo.bar?subject=Website%20Help&body=My%20problem%20is%20)

## テキスト書式

見出し、太字、テーブル、リストなどの書式には、Redmine は [Textile の構文](http://en.wikipedia.org/wiki/Textile_%28markup_language%29)に対応しています。これらの機能の使い方は、http://redcloth.org/hobix.com/textile/ を参照してください。以下にいくつか例を示しますが、エンジンはこれよりはるかに多くのことができます。

### 頭字語

    JPL(Jean-Philippe Lang)

表示:

JPL (Jean-Philippe Lang)

### フォントスタイル

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

表示:

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

### 色

    <code><notextile>* %{color:red}red% %{color:green}green% %{color:yellow}yellow% %{color:#82B6E1}blue'ish%
    * %{color:red}red%<notextile></notextile>%{color:green}green%<notextile></notextile>%{color:yellow}yellow%<notextile></notextile>%{color:#82B6E1}blue'ish%
    * %{background:lightgreen}Lightgreen Background% %{background:yellow}Yellow Background%
    * %{background:lightgreen}Lightgreen Background%<notextile></notextile>%{background:yellow}Yellow Background%
    </notextile></code>

表示:

\* <span style="color:red;">red</span> <span style="color:green;">green</span> <span style="color:yellow;">yellow</span> <span style="color:#82B6E1;">blue’ish</span>\
\* %{color:red}red%%{color:green}green%%{color:yellow}yellow%<span style="color:#82B6E1;">blue’ish</span>\
\* <span style="background:lightgreen;">Lightgreen Background</span> <span style="background:yellow;">Yellow Background</span>\
\* %{background:lightgreen}Lightgreen Background%<span style="background:yellow;">Yellow Background</span>

### インライン画像

- **!image_url!** は、image_url にある画像を表示します(Textile の構文)
- **!\>image_url!** は、右にフロートする画像を表示します
- **!image_url(Image title)!** は、alt 属性と title 属性の付いた画像を表示します
- **!image_url!:URL** は、image_url にある画像を、URL へのリンクを付けて表示します

Wikiページに添付した画像は、ファイル名を使ってインラインで表示できます: **!attached_image.png!**

SPAN にスタイルを設定するのと同じ方法で、画像に CSS のスタイルを適用することもできます。**!{width: 100%}attached_image.png!** と書くと、画像の幅が親要素の幅に合わせて調整されます。

### 見出し

    <code>h1. Heading

    h2. Subheading

    h3. Subheading
    </code>

Redmine はこれらの見出しにそれぞれアンカーを付けるため、「\#Heading」、「\#Subheading」などでリンクできます。

### 段落

    <code>p. left aligned

    p(. left ident 1em

    p((. left ident 2em
    as well as for following lines

    right aligned

    p)))>. right ident 3em

    This is centered paragraph.
    </code>

表示:

left aligned

p(. left ident 1em

p((. left ident 2em\
as well as for following lines

right aligned

p)))\>. right ident 3em

This is centered paragraph.

### 水平線

`----`

表示:

------------------------------------------------------------------------

### 整形済みテキスト

     <pre>*Your text won't become bold*

</pre>

表示:

     *Your text won't become bold* 

### 引用

段落の先頭に **bq.** を付けます。

    <code>bq. Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    To go live, all you need to add is a database and a web server.
    </code>

表示:

> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
> To go live, all you need to add is a database and a web server.

各行の先頭に \> を付けることもできます。\> を重ねると、入れ子の引用になります。

    >> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.
    >> To go live, all you need to add is a database and a web server.
    > Great!

表示:

\>\> Rails is a full-stack framework for developing database-backed web applications according to the Model-View-Control pattern.\
\>\> To go live, all you need to add is a database and a web server.\
\> Great!

### 順不同リスト

    * Item 1
    * Item 2
    ** Item 21
    ** Item 22
    * Item 3

表示:

- Item 1
- Item 2
  - Item 21
  - Item 22
- Item 3

### 番号つきリスト

    # Item 1
    # Item 2
    # Item 3
    ## Item 3.1
    ## Item 3.2

表示:

1.  Item 1
2.  Item 2
3.  Item 3
    1.  Item 3.1
    2.  Item 3.2

### テーブル

    |_.UserID      |_.Name          |_.Group     |_. attribute list   |
    |Starting with | a              |   simple   |row                 |
    |\3=.IT                                      |<. align left       |
    |1             |Artur Pirozhkov |/2.Users    |>. align right      |
    |2             |Vasya Rogov     |=. center   |
    |3             |John Smith      |Admin
                                     (root)      |^. valign top       |
    |4             |-               |Nobody
                                     (anonymous) |~. valign bottom    |

表示(連続する空白は 1 つにまとめられます):

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

テーブルの中にパイプ文字を入れる場合(Wiki のリンクなど)は、Textile がパイプ文字を解釈しないようにする必要があります。

| 入力 | 出力 |  |  |
|----|----|----|----|
| \*<notextile><notextile> | </notextile></notextile>\* | <notextile> | </notextile> |

テーブルの幅を指定する場合は、テーブルの定義の直前に **table{width:100%}.** を置く必要があります。

    table{width:100%}.
    | This table will use
    all horizontal space |

こうすると、テーブルはページの幅いっぱいに広がります…

<table>
<tbody>
<tr>
<td>This table will use<br />
all horizontal space</td>
</tr>
</tbody>
</table>

…標準の幅の場合と比べると、次のとおりです。

<table>
<tbody>
<tr>
<td>This table will use<br />
only the required space</td>
</tr>
</tbody>
</table>

**table** のキーワードの前には、空行が必要です。キーワードのあと(テーブルまで)には、空行もほかの内容も置けません。

#### テーブルの特殊な制御シーケンス

セルを区切るパイプ文字と制御シーケンスのあいだには、何も置けません。\
テーブルの制御シーケンスの順序は決まっています。順序の値が同じシーケンスは、優先度も同じです。\
テーブルの制御シーケンスを誤った順序で使うと、解釈されません。

| シーケンス | 順序 | 機能 |
|----------|-----|------------------------------------|
| \_       | 1   | セルの内容を強調する |
| \n       | 2   | *n* 個のセルを横に結合する |
| /n       | 2   | *n* 個のセルを縦に結合する |
| \<       | 3   | テキストを左揃えにする |
| =        | 3   | テキストを中央揃えにする |
| \>       | 3   | テキストを右揃えにする |
| ^        | 3   | テキストを上揃えにする |
| ~        | 3   | テキストを下揃えにする |
| .        | 4   | 制御シーケンスの終わり |

### 目次

    <code> => left aligned toc
     => right aligned toc
    </code>

toc のタグの上と下には空行が必要で、タグの前後にはほかのテキストを置けないことに注意してください。

例:

    <code>
    h1. headLineOne

    h2. something

    h2. something more
    </code>

### 脚注

マーカー:

    This is a first word[1] with a footnote.

    This is a second word[2] with a footnote.

**注:** マーカーは、単語のすぐあとに付けます(あいだに空白、ピリオドなど、何も入れません)。

定義:

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

例:

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

## CSS によるテキストのスタイル設定

Textile では、CSS を使ってテキストのスタイルを設定できます。例を次に示します。

    Three primary colors of light are %{color: #f00}red%, %{color: #0f0}green% and %{color: #00f}blue%.

    p{border: solid 1px [#000](https://www.redmine.org/issues/000); padding: 0.5em;}. The quick brown fox jumps over the lazy dog.

    table{width: 100%}.
    |={width: 30%; background-color: #aaf;}. column 1 |={width: 70%}. column 2 |

表示:

Three primary colors of light are %{color: \#f00}red%, <span style="color: #0f0;">green</span> and %{color: \#00f}blue%.

<div style="border: solid 1px [#000](https://www.redmine.org/issues/000); padding: 0.5em;;">

The quick brown fox jumps over the lazy dog.

</div>

|          |          |
|:--------:|:--------:|
| column 1 | column 2 |

### 使用できる CSS のプロパティ

Redmine で使用できるのは、次のプロパティです。そのほかのプロパティは、セキュリティ上の理由で使用できません(r2192 を参照)。

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

## 翻訳

次の翻訳は、最新ではない場合があります。必要に応じて、英語の元の文書を参照してください。

- [Português Brasileiro](https://www.redmine.org/projects/redmine/wiki/BrRedmineWikiFormatting)
- [Русский](https://www.redmine.org/projects/redmine/wiki/RusRedmineTextFormatting)
- [French](https://www.redmine.org/projects/redmine/wiki/FrRedmineWikiFormatting)
- [한글(Korean)](https://www.redmine.org/projects/redmine/wiki/KoreanWikiFormatting)
- [Türkçe](https://www.redmine.org/projects/redmine/wiki/TurkishWikiFormatting)
- [繁體中文](https://www.redmine.org/projects/redmine/wiki/TraditionalChineseWikiFormatting)
- [简体中文](https://www.redmine.org/projects/redmine/wiki/SimplifiedChineseWikiFormatting)
