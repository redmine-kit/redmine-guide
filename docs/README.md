# Redmine Guide

The [Redmine guide](https://www.redmine.org/guide) as Markdown, with translations, for [Redmine Help](https://redmine-kit.github.io/redmine_help/).

- [Updating from redmine.org](updating.md): fetch, compare, convert, review, merge
- [Translating](translating.md): rules, the glossary of interface terms, checks

## Contents

| Path | Contents |
| --- | --- |
| `en/<section>/<topic>.md` | The English guide, converted from the `upstream` branch. Front matter: the source page, its URL, version and update time |
| `ja/<section>/<topic>.md` | The Japanese translation. Front matter: the source page and `translated_from_version` |
| `images/<page>/` | The images the pages show, fetched from redmine.org |
| `index.yml` | The sections and their topics, in the guide's order (made by `bin/convert` from `guide.yml`) |
| `map.yml` | Redmine 7.0.3's screens to topics and headings, for Redmine Help |
| `topics.yml` | Each topic's source page on redmine.org (made by `bin/convert`) |
| `glossary/<lang>.yml` | Redmine's interface strings in English and the language (made by `bin/glossary`); `<lang>.extra.yml` for terms the locale has no string for |
| `guide.yml` | The sections, the topics' names, and the replacements of Redmine's old icons |
| `updates/<section>/<topic>.yml` | The changes that bring a page up to date with Redmine 7.0.3, applied by `bin/convert` ([Updates](updating.md#updates)) |

The guide has four sections: the user guide, the administrator guide, the installation guide and the developer guide. Redmine Help shows all of them; the map points Redmine's screens at the user and administrator guides.

## Installation

Redmine Help reads this guide from the gem `redmine-guide` or from a checkout ([Redmine Help's setup](https://redmine-kit.github.io/redmine_help/setup.html#the-guide)). Each version tag publishes the gem to GitHub Packages (`https://rubygems.pkg.github.com/redmine-kit`), which needs a GitHub token with `read:packages` even for a public package.

## Website

The website (https://redmine-kit.github.io/redmine-guide/) shows the guide in English and in Japanese. The Docs workflow builds it with [docs-skeleton](https://github.com/redmine-kit/docs-skeleton): before the build, `tools/site.rb` adds to `docs/` the guide's pages, the images they show, the sidebar (the order of `index.yml`, the Japanese titles of `glossary/ja.pages.yml`) and the top pages, and this page becomes "Overview" under "About this project". Each page ends with its original on redmine.org and the copyright, and what this project added with its license ([License](#license)). A page that is not translated yet is shown in English on the Japanese site, with the note 「言語: English」, as Redmine Help shows it.

To build the site locally, copy `docs/` into docs-skeleton as its README describes, then add the guide:

```sh
ruby tools/site.rb ../docs-skeleton/docs
```

## Sponsors

<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>

## License

The guide's English text and its images come from the Redmine wiki at https://www.redmine.org: © Jean-Philippe Lang and the Redmine contributors. redmine.org does not state a license for the wiki's text. Each page links its source.

The translations (`ja/`), the updates for Redmine 7.0.3 (`updates/` and the changes they make to the pages in `en/`) and the screenshots retaken in Redmine 7.0.3 (`images/<lang>/`) are this project's and are released under the Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0), the license that [redmine.jp](https://redmine.jp/guide/) uses for its Japanese translation of the guide. See [LICENSES/CC-BY-SA-4.0.txt](../LICENSES/CC-BY-SA-4.0.txt).

The tools are released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](../LICENSE).

An unofficial project for Redmine.
