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

## Sponsors

<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>

## License

Redmine Guide is released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](../LICENSE). An unofficial project for Redmine.
