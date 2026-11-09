# Redmine Guide

[![CI](https://img.shields.io/github/actions/workflow/status/redmine-kit/redmine-guide/ci.yml?branch=main&label=CI)](https://github.com/redmine-kit/redmine-guide/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/redmine-kit/redmine-guide?label=License)](LICENSE)

[Redmine のガイド](https://www.redmine.org/guide)を Markdown にし、翻訳を付けたものです。[Redmine Help](https://github.com/redmine-kit/redmine_help) が、ユーザーが開いている画面に合わせて Redmine の中に表示します。

[English](README.md)

- **`upstream` のブランチ:** redmine.org から取得したままのガイド(Wiki の Textile、画像、`manifest.json`)。`bin/fetch` で取得し直すと、差分で変わったところが分かります。
- **`main` のブランチ:** `upstream` から変換した Markdown(`en/`)、翻訳(`ja/`)、章(`index.yml`)、Redmine の画面とトピックの対応(`map.yml`)、画面の用語の用語集(`glossary/`)。

> **状態:** 開発の初期です(0.1.0)。英語のガイドはすべてそろっています。日本語の翻訳は最初のページからで、ほかのページは英語で表示します。

<a id="documentation"></a>

## ドキュメント

- Web サイト: https://redmine-kit.github.io/redmine-guide/ja/ (English: https://redmine-kit.github.io/redmine-guide/)
- Markdown: [docs/ja/README.md](docs/ja/README.md) (English: [docs/README.md](docs/README.md))

<a id="source-and-attribution"></a>

## 出典と著作権

ガイドの文と画像は、https://www.redmine.org の Redmine の Wiki から取得したものです(各ページの出典は、ページの先頭の front matter と、`upstream` の `manifest.json` にあります)。著作権は Jean-Philippe Lang と Redmine の貢献者にあります。redmine.org は、Wiki の文のライセンスを示していません。翻訳は、英語のページからこのプロジェクトが作ったものです(ほかの翻訳は使っていません)。このリポジトリのツールは、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。

<a id="sponsors"></a>

## スポンサー

<a href="https://www.keyselect.co.jp/">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/keyselect-logo-dark.svg">
    <img alt="KEY SELECT" src=".github/assets/keyselect-logo.svg" width="136" height="29">
  </picture>
</a>

<a id="license"></a>

## ライセンス

Redmine Guide は、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。[LICENSE](LICENSE) を参照してください。Redmine の非公式のプロジェクトです。
