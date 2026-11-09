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

   `en/`、`images/`、`index.yml`、`topics.yml` を書きます。`ja/` の翻訳には触れません。
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

- Wiki の Textile を、pandoc で GitHub の Markdown にする
- Wiki のリンク(`[[RedmineIssues#Updating|...]]`)を、トピックのあいだの相対のリンクにする。ガイドの外のページは redmine.org へのリンクにする。アンカーは Redmine の見出しのアンカーに合わせる
- 画像を `images/<ページ>/` に向ける
- 文の中の Redmine の古い PNG のアイコンを置き換える。後ろにラベルのあるアイコンは消し、ほかは `guide.yml` のとおりに置き換える(**Apply** のような Redmine のラベル)
- `#123` を redmine.org のチケットへのリンクにする
- 出典のページ、URL、バージョン、更新日時の front matter を付ける

CI は、`main` の Markdown が、`upstream` から `bin/convert` で作ったものと同じであることを確認します。
