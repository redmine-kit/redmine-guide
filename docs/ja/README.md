# Redmine Guide

[Redmine のガイド](https://www.redmine.org/guide)を Markdown にし、翻訳を付けたものです。[Redmine Help](https://redmine-kit.github.io/redmine_help/ja/) が使います。

- [redmine.org に合わせて更新する](updating.md): 取得、比較、変換、確認、マージ
- [翻訳する](translating.md): 決まり、画面の用語の用語集、検査

<a id="contents"></a>

## 中身

| パス | 中身 |
| --- | --- |
| `en/<章>/<トピック>.md` | 英語のガイド。`upstream` のブランチから変換したもの。front matter に出典のページ、URL、バージョン、更新日時 |
| `ja/<章>/<トピック>.md` | 日本語の翻訳。front matter に出典のページと `translated_from_version` |
| `images/<ページ>/` | ページが表示する画像。redmine.org から取得したもの |
| `index.yml` | 章とトピック。ガイドの順(`bin/convert` が `guide.yml` から作る) |
| `map.yml` | Redmine 7.0.3 の画面からトピックと見出しへの対応。Redmine Help が使う |
| `topics.yml` | トピックごとの redmine.org の出典のページ(`bin/convert` が作る) |
| `glossary/<言語>.yml` | Redmine の画面の文字列の英語とその言語(`bin/glossary` が作る)。ロケールにない用語は `<言語>.extra.yml` |
| `guide.yml` | 章、トピックの名前、Redmine の古いアイコンの置き換え |
| `updates/<章>/<トピック>.yml` | ページを Redmine 7.0.3 に合わせる変更。`bin/convert` が適用する ([更新](updating.md#updates)) |

ガイドは、ユーザーガイド、管理者ガイド、インストールガイド、開発者ガイドの 4 つの章です。Redmine Help はすべてを表示し、対応表は Redmine の画面をユーザーガイドと管理者ガイドに対応付けます。

<a id="installation"></a>

## インストール

Redmine Help は、このガイドを gem の `redmine-guide` か、チェックアウトから読みます([Redmine Help の準備](https://redmine-kit.github.io/redmine_help/ja/setup.html#the-guide))。バージョンのタグごとに gem を GitHub Packages(`https://rubygems.pkg.github.com/redmine-kit`)に公開します。公開のパッケージでも、`read:packages` のある GitHub のトークンが要ります。

<a id="website"></a>

## Web サイト

Web サイト (https://redmine-kit.github.io/redmine-guide/ja/) は、ガイドを英語と日本語で表示します。Docs のワークフローが [docs-skeleton](https://github.com/redmine-kit/docs-skeleton) でビルドします。ビルドの前に `tools/site.rb` が、ガイドのページ、ページが表示する画像、サイドバー (`index.yml` の順、`glossary/ja.pages.yml` の日本語のタイトル)、トップページを `docs/` に追加し、このページは「このプロジェクトについて」の「概要」になります。各ページの末尾には、redmine.org の原文と著作権、このプロジェクトが加えたものとそのライセンスを表示します ([ライセンス](#license))。まだ翻訳していないページは、日本語のサイトでは英語で表示し、Redmine Help と同じく「言語: English」と添えます。

サイトをローカルでビルドするには、docs-skeleton の README のとおりに `docs/` をコピーしてから、ガイドを追加します。

```sh
ruby tools/site.rb ../docs-skeleton/docs
```

<a id="sponsors"></a>

## スポンサー

<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>

<a id="license"></a>

## ライセンス

ガイドの英語の文と画像は、https://www.redmine.org の Redmine の Wiki から取得したもので、著作権は Jean-Philippe Lang と Redmine の貢献者にあります。redmine.org は、Wiki の文のライセンスを示していません。各ページに出典へのリンクがあります。

翻訳 (`ja/`)、Redmine 7.0.3 に合わせた更新 (`updates/` と、それによる `en/` のページの変更)、Redmine 7.0.3 で撮り直したスクリーンショット (`images/<言語>/`) は、このプロジェクトが作ったもので、クリエイティブ・コモンズ 表示 - 継承 4.0 国際 ライセンス (CC BY-SA 4.0) で公開しています。[redmine.jp](https://redmine.jp/guide/) がガイドの日本語訳に使っているライセンスと同じです。[LICENSES/CC-BY-SA-4.0.txt](../../LICENSES/CC-BY-SA-4.0.txt) を参照してください。

ツールは、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。[LICENSE](../../LICENSE) を参照してください。

Redmine の非公式のプロジェクトです。
