# Translating

Take particular care with wording. A translation is read next to the screen it describes.

## Rules

- **Interface terms exactly as Redmine shows them.** A menu, tab, field, button, setting, permission or status is named with the string from Redmine 7.0.3's `config/locales/<lang>.yml`, so that the reader finds the same words on the screen. Look it up in `glossary/<lang>.yml`; do not translate it again. Mark it as a name: 「適用」 in Japanese (or **適用**).
- **Established terms.** A term the locale has no string for takes the established term in the language's software (for Japanese, Microsoft's terminology and Japanese Style Guide) rather than a new wording. It goes in `glossary/<lang>.extra.yml` with its source.
- **Consistent terms.** The same thing has the same name on every page.
- **Page titles.** A page's H1 is its title in `glossary/<lang>.pages.yml`: a page about a screen is named as Redmine names the screen. Where another page names it, use the same title.
- **Natural and precise.** Write as a native technical writer would, not word for word. Keep the meaning exactly; add and drop nothing. Keep the page's structure, links and images.
- **Headings one for one.** The translation has the English page's headings, with the same count and levels, in the same order. Redmine Help finds an English anchor (`settings.md#Authentication`, `map.yml`) in a translation by the heading's position, so links keep the English anchor and translations add no anchor tags.
- **Code blocks and alerts.** Code blocks are fenced, with the English page's language (`text` when it has none). An alert (`> [!CAUTION] Note`) keeps its kind; its title is translated (Note → 注記).
- **Images.** Keep the English page's image references; `bin/screenshots` takes each language's screenshots and the references are switched to them.
- **Japanese.** Plain, precise Japanese, following the organization's wording rules: 「通知」 not 「知らせ」, 「確認」 not 「確かめ」, 「インストール」, 「コピー」, 「バージョンアップ」, 「例外を発生させる」, and no 「版」 for a version.
- **Review.** Before committing, read the translation against the English page and the screen in Redmine 7.0.3.

## A new translation

1. Copy the English page's path: `en/user/news.md` becomes `ja/user/news.md`.
2. Write the front matter with the source page and the English page's version:

   ```yaml
   ---
   source: RedmineNews
   translated_from_version: 12
   ---
   ```

3. Translate the page, keeping the images and links (a link to a page not translated yet works: Redmine Help shows that page in English).
4. Run the checks:

   ```sh
   bin/check
   ```

## Glossary

`glossary/<lang>.yml` lists Redmine's interface strings (labels, fields, buttons, settings, permissions, project modules and the default data) in English and the language, made from Redmine's locale files:

```sh
bin/glossary ja
```

It is made again when the guide follows a new Redmine version (`REDMINE_VERSION`, `REDMINE_SHA256`).

## Checks

`bin/check` (also in CI) reports:

- a broken link to a page or an image;
- a translation without `translated_from_version`, or made from an older version of the English page;
- an interface term the English page marks in bold (**Apply**) that the glossary knows, when the translation does not use Redmine's string for it marked as a name (「適用」);
- a topic or a heading in `map.yml` or `index.yml` that does not exist, or a topic in `index.yml` without a title in one of the index's languages;
- a translation whose H1 is not its title in `glossary/<lang>.pages.yml`, whose headings differ from the English page's in count or levels, or that has anchor tags.
- a page (English or translated) where the conversion left Textile or broke what a reader sees: a macro, `<code class>` in a code block, an escaped list marker (`\*`), a list split in two (`<!-- -->`), a broken link such as `![#124](...)`, Textile headings, tables or links, footnote markers other than Redmine's, an HTML tag that Markdown would hide, an indented code block, full-width characters in the ASCII art of a code block (write it in ASCII, with the names in a legend below), an image from another site, or an inline background colour (outside the text formatting pages, which show it as an example).
