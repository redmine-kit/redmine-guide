# redmine-guide: upstream

This branch is the Redmine guide exactly as fetched from https://www.redmine.org/guide: the Textile source of each wiki page (`pages/`), the images the pages show (`images/`), and `manifest.json` (URL, page version, update time, fetch date). Nothing here is edited by hand.

`bin/fetch` on the `main` branch fetches the guide again into this branch, so that `git diff` shows what changed on redmine.org. The converted and translated guide is on `main`.

The guide's text and images are © Jean-Philippe Lang and the Redmine contributors (https://www.redmine.org).
