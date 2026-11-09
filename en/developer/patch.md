---
source: Patch
source_url: https://www.redmine.org/projects/redmine/wiki/Patch
source_version: 8
source_updated_on: '2024-10-19T15:01:44Z'
---

# Patch

A patch file is a single file that will list all the changes made to Redmine. It is the preferred way to create and share changes to Redmine.

## Creating a patch file

Creating a patch for Redmine is easy. Just follow the following simple steps:

1.  Download the development copy of Redmine
2.  *Make your changes*
3.  Run `svn diff > PATCH_NAME.diff` in you Redmine folder (if using git run `git diff > PATCH_NAME.diff`). Change PATCH_NAME to something that describes the purpose.
4.  Upload the patch file to an issue and share

## Applying a patch file

To apply a patch file you can use the [patch](http://www.gnu.org/software/patch/) program.

1.  Change into your Redmine directory (the one with app, test, and config folders)
2.  Run `patch -p0 < PATCH_NAME.diff` (if using git run `git apply PATCH_NAME.diff`)
3.  Check the messages for any errors.

Some errors might occur because there are changes to the same areas of code. If you are familiar with merging code, you can try to merge the changes. Otherwise post for help where you downloaded the patch or in the forums.

## Remove a patch file

To remove a patch file you can use the [patch](http://www.gnu.org/software/patch/) program.

1.  Change into your Redmine directory (the one with app, test, and config folders)
2.  Run `patch -p0 -R < PATCH_NAME.diff` (if using git run `git apply -R PATCH_NAME.diff`)
3.  Check the messages for any errors.
