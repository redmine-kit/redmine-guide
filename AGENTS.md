# AGENTS.md

Guidelines for people and coding agents working in this repository. See [README.md](README.md) for an overview and [docs/](docs/README.md) for the details. The organization's rules are in `../AGENTS.md` (outside this repository, next to the other redmine-kit checkouts).

## What this project does

Redmine Guide is the Redmine guide from redmine.org as Markdown, with translations, the sections and the map from Redmine's screens to topics, for [Redmine Help](https://github.com/redmine-kit/redmine_help).

## Branches

- **`upstream`:** the guide exactly as fetched (`bin/fetch`). Never edit it by hand.
- **`main`:** the tools, `en/` converted from `upstream` (`bin/convert`; never edit `en/` by hand, change the conversion or `guide.yml`), the translations, `map.yml` and the glossaries.

## Translations

Take particular care with wording ([docs/translating.md](docs/translating.md)):

- **Interface terms exactly as Redmine shows them.** Every menu, tab, field, button, setting, permission and status name is the string from Redmine 7.0.3's `config/locales/<lang>.yml` (and the plugin's locale for plugin screens), looked up in `glossary/<lang>.yml`, not translated again. In Japanese, mark it as a name: 「適用」.
- **Established terms** where the locale has no string (Japanese: Microsoft's terminology and Japanese Style Guide), in `glossary/<lang>.extra.yml` with the source; **consistent terms** on every page.
- **Page titles** from `glossary/<lang>.pages.yml` (a screen's page is named as Redmine names the screen).
- **Headings one for one** with the English page (count, levels, order); links keep English anchors; no anchor tags. **Images:** keep the English references; `bin/screenshots` switches them.
- **Natural and precise**, as a native technical writer would write it; nothing added or dropped; structure, headings, links and images kept.
- **Japanese wording:** 「通知」 not 「知らせ」, 「確認」 not 「確かめ」, 「インストール」, 「コピー」, 「バージョンアップ」, 「例外を発生させる」, no 「版」 for a version.
- **Quality over speed:** translate fewer pages well rather than many quickly. Record `translated_from_version`.
- **Review** each page against the English and Redmine 7.0.3's screen before committing, and run `bin/check`.

## Documentation

- **Two languages.** English is the source (`README.md`, `docs/`); the Japanese translation is `README.ja.md` and `docs/ja/`. Change both together; put `<a id="...">` with the English heading's anchor before each Japanese heading.
- **Commands** to run go in `sh` blocks with a lead sentence.

## Commits

- English, imperative mood, 72 characters or fewer in the first line, no trailing period.
- One purpose per commit. Do not rewrite pushed history.
