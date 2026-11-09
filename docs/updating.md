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

- converts the wiki's Textile to GitHub Markdown with pandoc;
- turns wiki links (`[[RedmineIssues#Updating|...]]`) into relative links between topics, or into links to redmine.org for pages outside the guide; anchors follow Redmine's heading anchors;
- points images at `images/<page>/`;
- replaces Redmine's old PNG icons in the text: an icon followed by its label is dropped; the others are replaced as `guide.yml` lists (with Redmine's labels, such as **Apply**);
- links `#123` to redmine.org's issues;
- adds front matter with the source page, its URL, version and update time.

CI checks that the Markdown on `main` is what `bin/convert` makes from `upstream`.
