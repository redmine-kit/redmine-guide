# Updating from redmine.org

The guide on redmine.org changes from time to time. The `upstream` branch keeps the guide exactly as fetched, so that a diff shows what changed, and `main` is made from it again.

## Steps

1. **Fetch.** Fetch the guide into `upstream` and commit it there:

   ```sh
   bin/fetch
   ```

   `bin/fetch` requests the pages one by one with a delay (1.5 s; `FETCH_DELAY`), follows renamed pages, and respects robots.txt. With each page it fetches the images the page shows, also those it shows from redmine.org by their URL (recorded in `manifest.json` under `image_sources`), so that the guide shows no image from another site. It fetches the page Guide, the pages it includes, the pages they link, and the pages those link whose wiki parent is a guide page. The guides in other languages are not fetched.
2. **Compare.** See what changed on redmine.org:

   ```sh
   git diff upstream~1 upstream
   ```

3. **Convert.** Make the Markdown on `main` again from `upstream`:

   ```sh
   bin/convert
   ```

   It writes `en/`, `images/`, `index.yml` and `topics.yml`, with the [updates for Redmine 7.0.3](#updates). The translations in `ja/` are not touched. When it stops because the text an update replaces is no longer on a page, see [Updates](#updates).
4. **Review.** Read the diff of `en/`. New pages of the guide need a place in `guide.yml` (a section and a name); `bin/convert` puts pages it does not list under the section of the page that links them.
5. **Check.** List the translations whose English page changed, and broken links:

   ```sh
   bin/check
   ```

   A translation records the version of the English page it was made from (`translated_from_version`). When the English page has a newer version, `bin/check` reports it as stale; update the translation and its `translated_from_version`.
6. **Merge.** Commit on `main`, with the translations that were updated, and publish a new version of the gem.

## Conversion

`bin/convert` (`tools/convert.rb`, run in Docker with pandoc 3.11):

- converts the wiki's Textile to GitHub Markdown with pandoc, and renders itself what pandoc gets wrong in Redmine's Textile (`tools/textile.rb`, after Redmine's own rendering): `<pre>` blocks as fenced code blocks with their language (`text` when they have none), a table of one cell with a background colour (a note) as an alert (`> [!CAUTION] Note`: the colour gives the kind, the cell's bold label the title), `@code@` as inline code (also next to punctuation, and with `@` inside), HTML tags other than `<pre>`, `<code>`, `<kbd>` and `<notextile>` as text, footnotes as Redmine shows them (a superscript number and the note in place), tables with spanned or aligned cells as HTML, indented list items as nested lists, escaped Redmine links (`!#124`) as their text, `{{collapse}}` as a `<details>` section, lines that start with `>` as a quote, `%{color: red}text%` as a styled span, and `<notextile>` as literal text;
- turns wiki links (`[[RedmineIssues#Updating|...]]`) into relative links between topics, or into links to redmine.org for pages outside the guide; anchors follow Redmine's heading anchors;
- points images at the screenshot retaken in Redmine 7.0.3 (`images/en/<page>/`, see [Screenshots](#screenshots)), or else at the old image in `images/<page>/`; in the translations, at the screenshot in their language (`images/<lang>/<page>/`);
- replaces Redmine's old PNG icons in the text: an icon followed by its label is dropped; the others are replaced as `guide.yml` lists (with Redmine's labels, such as **Apply**);
- links `#123` to redmine.org's issues, and shows Redmine's links to other objects of redmine.org as redmine.org shows them: a version by its name (`version#43`, `version:2.3.0`), a forum message by its subject (`message#36062`; both listed in `guide.yml`), a revision (`r3162`) and a file of the repository (`source:...`), each linked to redmine.org;
- adds front matter with the source page, its URL, version and update time.

CI checks that the Markdown on `main` is what `bin/convert` makes from `upstream`.

## Updates

The guide on redmine.org does not always describe the Redmine version that this guide follows (7.0.3). The changes that bring a page up to date are kept apart from the conversion, in `updates/<section>/<topic>.yml`, and `bin/convert` applies them to the converted page:

```yaml
redmine: 7.0.3
updates:
  - why: what is different in Redmine 7.0.3
    source: where Redmine 7.0.3's source shows it (a file, an en.yml key)
    replace: |-
      the text of the converted page
    with: |-
      the new text
```

- **Exactly once.** Each text to replace must be on the converted page exactly once, or `bin/convert` stops. A change on redmine.org therefore never undoes an update silently: read the new page, then change or drop the update (drop it when redmine.org fixed the page itself).
- **Marked.** A page with updates has `updated_for: 7.0.3` in its front matter. The `upstream` branch keeps the page as redmine.org has it, for comparison.
- **Translations.** Change the translation in the same commit as the update (its `translated_from_version` stays: the source page did not change).
- **Facts from the source.** Check each update against Redmine 7.0.3's source (`app/`, `lib/`, `config/locales/en.yml`, `Gemfile`), and use the screen's own strings.

## Screenshots

The images on redmine.org were taken in old versions of Redmine, in English. `bin/screenshots` takes them again in Redmine 7.0.3, in every language, with Redmine's test data, and runs `bin/convert`, which puts them into the pages:

```sh
bin/screenshots
```

The test data gets the few records that the screens need and the fixtures lack (`prepare_data` in `screenshots/screens.rb`), such as a user waiting for activation and subtasks in a version. The browser runs in the language of the screenshots, so that its own controls (file and date fields) are in that language too.

In the other languages the screens show data in that language as well: `screenshots/data/<lang>.yml` renames the fixtures' records (trackers, statuses, priorities and the other enumerations as Redmine's default data in that language; projects, issues, users and the rest as a team using that language would name them) before the shots of that language. Identifiers such as logins, project identifiers, file names and version numbers stay as they are. When a translated page names a value that its image shows (a tracker, a status), it uses the value of the image.

Each shot in `screenshots/screens.rb` is named after the image it replaces (`RedmineIssueList/sidebar.jpg` becomes `images/<lang>/RedmineIssueList/sidebar@2x.png`), opens the screen and says what to capture. To take some of them again, give a pattern:

```sh
ONLY=RedmineIssueList bin/screenshots
```

An image with no shot keeps the old one: the screen no longer exists in Redmine 7.0.3 (the change log), it needs code that is not in Redmine (the plugin tutorial), or it shows a theme Redmine no longer ships.
