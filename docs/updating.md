# Updating from redmine.org

The guide on redmine.org changes from time to time. The `upstream` branch keeps the guide exactly as fetched, so that a diff shows what changed, and `main` is made from it again.

## Steps

1. **Fetch.** Fetch the guide into `upstream` and commit it there:

   ```sh
   bin/fetch
   ```

   `bin/fetch` requests the pages one by one with a delay (1.5 s; `FETCH_DELAY`), follows renamed pages, and respects robots.txt. It fetches the page Guide, the pages it includes, the pages they link, and the pages those link whose wiki parent is a guide page. The guides in other languages are not fetched.
2. **Compare.** See what changed on redmine.org:

   ```sh
   git diff upstream~1 upstream
   ```

3. **Convert.** Make the Markdown on `main` again from `upstream`:

   ```sh
   bin/convert
   ```

   It writes `en/`, `images/`, `index.yml` and `topics.yml`. The translations in `ja/` are not touched.
4. **Review.** Read the diff of `en/`. New pages of the guide need a place in `guide.yml` (a section and a name); `bin/convert` puts pages it does not list under the section of the page that links them.
5. **Check.** List the translations whose English page changed, and broken links:

   ```sh
   bin/check
   ```

   A translation records the version of the English page it was made from (`translated_from_version`). When the English page has a newer version, `bin/check` reports it as stale; update the translation and its `translated_from_version`.
6. **Merge.** Commit on `main`, with the translations that were updated, and publish a new version of the gem.

## Conversion

`bin/convert` (`tools/convert.rb`, run in Docker with pandoc 3.11):

- converts the wiki's Textile to GitHub Markdown with pandoc, and renders itself what pandoc gets wrong in Redmine's Textile (`tools/textile.rb`, after Redmine's own rendering): `<pre>` blocks as code blocks with their language, HTML tags other than `<pre>`, `<code>`, `<kbd>` and `<notextile>` as text, footnotes as Redmine shows them (a superscript number and the note in place), tables with spanned or aligned cells as HTML, indented list items as nested lists, escaped Redmine links (`!#124`) as their text, `{{collapse}}` as a `<details>` section, and `<notextile>` as literal text;
- turns wiki links (`[[RedmineIssues#Updating|...]]`) into relative links between topics, or into links to redmine.org for pages outside the guide; anchors follow Redmine's heading anchors;
- points images at the screenshot retaken in Redmine 7.0.3 (`images/en/<page>/`, see [Screenshots](#screenshots)), or else at the old image in `images/<page>/`; in the translations, at the screenshot in their language (`images/<lang>/<page>/`);
- replaces Redmine's old PNG icons in the text: an icon followed by its label is dropped; the others are replaced as `guide.yml` lists (with Redmine's labels, such as **Apply**);
- links `#123` to redmine.org's issues;
- adds front matter with the source page, its URL, version and update time.

CI checks that the Markdown on `main` is what `bin/convert` makes from `upstream`.

## Screenshots

The images on redmine.org were taken in old versions of Redmine, in English. `bin/screenshots` takes them again in Redmine 7.0.3, in every language, with Redmine's test data, and runs `bin/convert`, which puts them into the pages:

```sh
bin/screenshots
```

Each shot in `screenshots/screens.rb` is named after the image it replaces (`RedmineIssueList/sidebar.jpg` becomes `images/<lang>/RedmineIssueList/sidebar@2x.png`), opens the screen and says what to capture. To take some of them again, give a pattern:

```sh
ONLY=RedmineIssueList bin/screenshots
```

An image with no shot keeps the old one: the screen no longer exists in Redmine 7.0.3 (the change log), it needs code that is not in Redmine (the plugin tutorial), or it shows a theme Redmine no longer ships.
