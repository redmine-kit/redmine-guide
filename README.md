# Redmine Guide

[![CI](https://img.shields.io/github/actions/workflow/status/redmine-kit/redmine-guide/ci.yml?branch=main&label=CI)](https://github.com/redmine-kit/redmine-guide/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/redmine-kit/redmine-guide?label=License)](LICENSE)

The [Redmine guide](https://www.redmine.org/guide) as Markdown, with translations, for [Redmine Help](https://github.com/redmine-kit/redmine_help), which shows it inside Redmine for the screen the user is on.

[日本語](README.ja.md)

- **`upstream` branch:** the guide exactly as fetched from redmine.org (the wiki's Textile, the images, `manifest.json`). `bin/fetch` fetches it again, so that a diff shows what changed.
- **`main` branch:** the Markdown converted from `upstream` (`en/`), the translations (`ja/`), the sections (`index.yml`), the map from Redmine's screens to topics (`map.yml`), and the glossaries of interface terms (`glossary/`).

> **Status:** early development (0.1.0). The English guide is complete; the Japanese translation covers the first pages, and the other pages are shown in English.

## Documentation

- Website: https://redmine-kit.github.io/redmine-guide/ (日本語: https://redmine-kit.github.io/redmine-guide/ja/)
- Markdown: [docs/README.md](docs/README.md) (日本語: [docs/ja/README.md](docs/ja/README.md))

## Source and attribution

The guide's text and images come from the Redmine wiki at https://www.redmine.org (the source of each page is in its front matter and in `manifest.json` on `upstream`). They are © Jean-Philippe Lang and the Redmine contributors; redmine.org does not state a license for the wiki's text. The translations are this project's own, made from the English pages (not from other translations). The tools in this repository are released under the GNU General Public License, version 2 or (at your option) any later version.

## Sponsors

<a href="https://www.keyselect.co.jp/">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/keyselect-logo-dark.svg">
    <img alt="KEY SELECT" src=".github/assets/keyselect-logo.svg" width="136" height="29">
  </picture>
</a>

## License

Redmine Guide is released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](LICENSE). An unofficial project for Redmine.
