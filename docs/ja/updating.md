# redmine.org に合わせて更新する

redmine.org のガイドは、ときどき変わります。`upstream` のブランチは取得したままのガイドを持つので、差分で変わったところが分かります。`main` は、それからもう一度作ります。

<a id="steps"></a>

## 手順

1. **取得する:** ガイドを `upstream` に取得し、そこでコミットします。

   ```sh
   bin/fetch
   ```

   `bin/fetch` は、ページを 1 つずつ、間を空けて(1.5 秒。`FETCH_DELAY`)取得します。名前の変わったページをたどり、robots.txt に従います。取得するのは、Guide のページ、それが含むページ、それらがリンクするページ、さらにそれらがリンクするページのうち Wiki の親がガイドのページであるものです。ほかの言語のガイドは取得しません。
2. **比べる:** redmine.org で変わったところを見ます。

   ```sh
   git diff upstream~1 upstream
   ```

3. **変換する:** `upstream` から `main` の Markdown をもう一度作ります。

   ```sh
   bin/convert
   ```

   `en/`、`images/`、`index.yml`、`topics.yml` を書きます。[Redmine 7.0.3 に合わせた更新](#updates)も適用します。`ja/` の翻訳には触れません。更新が置き換える文がページからなくなって止まったときは、[更新](#updates)を参照してください。
4. **確認する:** `en/` の差分を読みます。ガイドに新しいページがあれば、`guide.yml` に置き場所(章と名前)を足します。`bin/convert` は、`guide.yml` にないページを、それをリンクするページの章に置きます。
5. **検査する:** 英語のページが変わった翻訳と、切れたリンクを一覧にします。

   ```sh
   bin/check
   ```

   翻訳は、翻訳のもとにした英語のページのバージョン(`translated_from_version`)を記録しています。英語のページのバージョンが新しくなると、`bin/check` は古い翻訳として報告します。翻訳と `translated_from_version` を更新します。
6. **マージする:** 更新した翻訳と一緒に `main` でコミットし、gem の新しいバージョンを公開します。

<a id="conversion"></a>

## 変換

`bin/convert`(`tools/convert.rb`。Docker の中の pandoc 3.11 で動かす)は、次のことをします。

- Wiki の Textile を、pandoc で GitHub の Markdown にする。pandoc が誤る Redmine の Textile は、Redmine の表示に合わせて自前で変換する (`tools/textile.rb`)。`<pre>` のブロックは言語付きのコードブロックに、`@code@` は記号の隣や `@` を含むときもインラインコードに、`<pre>`、`<code>`、`<kbd>`、`<notextile>` 以外の HTML タグは文字に、脚注は Redmine と同じ表示 (上付きの番号と、その場所の注) に、セルの結合や配置のある表は HTML に、字下げしたリストの項目は入れ子のリストに、エスケープした Redmine のリンク (`!#124`) はそのテキストに、`{{collapse}}` は `<details>` のセクションに、`>` で始まる行は引用に、`%{color: red}text%` はスタイル付きの span に、`<notextile>` はそのままの文字にする
- Wiki のリンク(`[[RedmineIssues#Updating|...]]`)を、トピックのあいだの相対のリンクにする。ガイドの外のページは redmine.org へのリンクにする。アンカーは Redmine の見出しのアンカーに合わせる
- 画像を、Redmine 7.0.3 で撮り直したスクリーンショット(`images/en/<ページ>/`、[スクリーンショット](#screenshots)を参照)に向け、なければ `images/<ページ>/` の古い画像に向ける。翻訳では、その言語のスクリーンショット(`images/<言語>/<ページ>/`)に向ける
- 文の中の Redmine の古い PNG のアイコンを置き換える。後ろにラベルのあるアイコンは消し、ほかは `guide.yml` のとおりに置き換える(**Apply** のような Redmine のラベル)
- `#123` を redmine.org のチケットへのリンクにする
- 出典のページ、URL、バージョン、更新日時の front matter を付ける

CI は、`main` の Markdown が、`upstream` から `bin/convert` で作ったものと同じであることを確認します。

<a id="updates"></a>

## 更新

redmine.org のガイドは、このガイドが対象とする Redmine のバージョン (7.0.3) に合っていないことがあります。ページを最新にする変更は、変換とは分けて `updates/<章>/<トピック>.yml` に置き、`bin/convert` が変換したページに適用します。

```yaml
redmine: 7.0.3
updates:
  - why: Redmine 7.0.3 で違うこと
    source: Redmine 7.0.3 のソースの根拠 (ファイル、en.yml のキー)
    replace: |-
      変換したページの文
    with: |-
      新しい文
```

- **1 か所だけ:** 置き換える文は、変換したページにちょうど 1 か所なければなりません。そうでなければ `bin/convert` は止まります。そのため、redmine.org の変更が更新を黙って元に戻すことはありません。新しいページを読み、更新を直すか削除します (redmine.org がページを直したときは削除します)。
- **印:** 更新のあるページは、front matter に `updated_for: 7.0.3` があります。比べるために、`upstream` ブランチには redmine.org のままのページが残ります。
- **翻訳:** 翻訳は、更新と同じコミットで直します。もとのページは変わっていないので、`translated_from_version` はそのままです。
- **ソースの事実:** 更新は Redmine 7.0.3 のソース (`app/`、`lib/`、`config/locales/en.yml`、`Gemfile`) で確認し、画面の文字列をそのまま使います。

<a id="screenshots"></a>

## スクリーンショット

redmine.org の画像は、古いバージョンの Redmine で英語の画面を撮ったものです。`bin/screenshots` は、Redmine 7.0.3 と Redmine のテスト用のデータで、すべての言語の画面を撮り直し、`bin/convert` を実行してページに入れます。

```sh
bin/screenshots
```

`screenshots/screens.rb` の各ショットは、置き換える画像の名前を持ち(`RedmineIssueList/sidebar.jpg` は `images/<言語>/RedmineIssueList/sidebar@2x.png` になります)、画面を開いて撮る範囲を返します。一部だけ撮り直すには、パターンを渡します。

```sh
ONLY=RedmineIssueList bin/screenshots
```

ショットのない画像は、古い画像のままです。Redmine 7.0.3 にない画面(変更履歴)、Redmine にないコードが要る画面(プラグインのチュートリアル)、Redmine に同梱されなくなったテーマの画面がこれに当たります。
