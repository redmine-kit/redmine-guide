---
source: HowTo_create_a_custom_Redmine_theme
translated_from_version: 14
---

# カスタムテーマの作成

Redmine は基本的なテーマの機能を備えています。テーマでは、スタイルシート(application.css)を上書きし、独自の JavaScript を追加できます。

**注**: Redmine 6.0 から、テーマの場所が `public/themes` から `themes` に変わりました。6.0 より前のバージョン向けのテーマを作成する場合は、以下の説明の `themes` を `public/themes` と読み替えてください。

## 新しいテーマの作成

`/themes` にディレクトリを作成します。ディレクトリの名前がテーマの名前になります。

例:

themes/my_theme

独自の `application.css` を作成し、`stylesheets` というサブディレクトリに保存します。

themes/my_theme/stylesheets/application.css

いくつかの設定だけを上書きする、独自のスタイルシートの例です。

```css
/* load the default Redmine stylesheet */
@import url(../../../stylesheets/application.css);

/* add a logo in the header */
#header {
    background: #507AAA url(../images/logo.png) no-repeat 2px;
    padding-left: 86px;
}


/* move the project menu to the right */
#main-menu {
    left: auto;
    right: 0px;
}
```

この例では、`my_theme/images/logo.png` に画像があるものとしています。

このサンプルのテーマをダウンロードして、自分のテーマの出発点にできます。`/themes` ディレクトリに展開してください。

**注**: Redmine 6.0 から、上の例の `@import url(../../../stylesheets/application.css)` は、Redmine の起動時に自動で `@import url("/assets/application-29b28b2c.css");` に変換されます。ファイル名の末尾の英数字は、ファイルの内容から計算したハッシュ値です。内容を変更するたびにファイル名が変わるため、ブラウザが古いキャッシュを使って表示が崩れるといった問題が起きません。

## 独自の JavaScript の追加

JavaScript を `javascripts/theme.js` に置くだけで、すべてのページで自動的に読み込まれます。

**注**: Redmine 6.0 から、JavaScript で画像のパスを指定するときは、次の例のように疑似メソッド `RAILS_ASSET_URL` を使います。変換の詳しい仕様は [README of propshaft](https://github.com/rails/propshaft?tab=readme-ov-file#referencing-digested-assets-in-css-and-javascript) を参照してください。

変換前:

```javascript
export default class extends Controller {
  init() {
    this.img = RAILS_ASSET_URL("/icons/trash.svg")
  }
}
```

変換後:

```javascript
export default class extends Controller {
  init() {
    this.img = "/assets/icons/trash-54g9cbef.svg"
  }
}
```

## ファビコンの設定

ファビコンを `favicon` ディレクトリに置くと、すべてのページで、デフォルトのものの代わりに自動的に読み込まれます。ファビコンのファイル名は何でもかまいません。

## テーマの適用

「管理」→「設定」で、「テーマ」のドロップダウンリストから作成したテーマを選び、設定を保存します。\
これで、Redmine が作成したテーマで表示されます。

## テーマのディレクトリ構成

テーマは次のファイルで構成されます。

- `favicon/<favicon file>`(任意): テーマのファビコン
- `javascripts/theme.js`(任意): テーマの独自の JavaScript
- `stylesheets/application.css`(必須): テーマの CSS

```text
themes/
  +- <theme name>/
       |
       +- favicon/
       |    +- <favicon file> (e.g. favicon.ico, favicon.png)
       |
       +- javascripts/
       |    +- theme.js
       |
       +- stylesheets/
            +- application.css
```
