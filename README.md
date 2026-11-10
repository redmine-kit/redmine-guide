# Redmine Guide

[![CI](https://img.shields.io/github/actions/workflow/status/redmine-kit/redmine-guide/ci.yml?branch=main&label=CI)](https://github.com/redmine-kit/redmine-guide/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/redmine-kit/redmine-guide?label=License)](LICENSE)

The [Redmine guide](https://www.redmine.org/guide) as Markdown, with translations, for [Redmine Help](https://github.com/redmine-kit/redmine_help), which shows it inside Redmine for the screen the user is on.

[日本語](README.ja.md)

- **`upstream` branch:** the guide exactly as fetched from redmine.org (the wiki's Textile, the images, `manifest.json`). `bin/fetch` fetches it again, so that a diff shows what changed.
- **`main` branch:** the Markdown converted from `upstream` (`en/`), the translations (`ja/`), the sections (`index.yml`), the map from Redmine's screens to topics (`map.yml`), and the glossaries of interface terms (`glossary/`).

> **Status:** early development (0.1.0). The English guide is complete and updated for Redmine 7.0.3, and every page is translated into Japanese.

## Documentation

- Website: https://redmine-kit.github.io/redmine-guide/ (日本語: https://redmine-kit.github.io/redmine-guide/ja/)
- Markdown: [docs/README.md](docs/README.md) (日本語: [docs/ja/README.md](docs/ja/README.md))

## Source and attribution

The guide's text and images come from the Redmine wiki at https://www.redmine.org (the source of each page is in its front matter and in `manifest.json` on `upstream`). They are © Jean-Philippe Lang and the Redmine contributors; redmine.org does not state a license for the wiki's text ([License](#license)). The translations are this project's own, made from the English pages (not from other translations).

## Sponsors

<a href="https://www.keyselect.co.jp/">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/keyselect-logo-dark.svg">
    <img alt="KEY SELECT" src=".github/assets/keyselect-logo.svg" width="136" height="29">
  </picture>
</a>

## License

The guide's English text and its images come from the Redmine wiki at https://www.redmine.org: © Jean-Philippe Lang and the Redmine contributors. redmine.org does not state a license for the wiki's text. Each page links its source.

The translations (`ja/`), the updates for Redmine 7.0.3 (`updates/` and the changes they make to the pages in `en/`) and the screenshots retaken in Redmine 7.0.3 (`images/<lang>/`) are this project's and are released under the Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0), the license that [redmine.jp](https://redmine.jp/guide/) uses for its Japanese translation of the guide. See [LICENSES/CC-BY-SA-4.0.txt](LICENSES/CC-BY-SA-4.0.txt).

The tools are released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](LICENSE).

An unofficial project for Redmine.
