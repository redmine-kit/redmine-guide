---
source: How_to_create_patch_series_on_Mercurial_and_Git
source_url: https://www.redmine.org/projects/redmine/wiki/How_to_create_patch_series_on_Mercurial_and_Git
source_version: 2
source_updated_on: '2012-03-16T11:00:05Z'
---

# How to create patch series on Mercurial and Git

## Mercurial

You can use “hg export”.

    $ hg log -l 2
    changeset:   8260:d0d25df3c46b
    branch:      git-fetch-20120316-original
    tag:         tip
    user:        test
    date:        Fri Mar 16 11:25:26 2012 +0900
    summary:     Process new git revisions all at once rather than per

    changeset:   8259:30d69339f9a2
    branch:      git-fetch-20120316-original
    user:        test
    date:        Fri Mar 16 11:25:10 2012 +0900
    summary:     Pass revisions to git-log via stdin

    $ hg export -r 8259:8260 > example.diff

## Git

You can use “git format-patch”.

    $ git log -n 2 | cat
    commit 3137eff804b0fc35b03e5c9c3ff574617f8a5bc7
    Author: test
    Date:   Fri Mar 16 19:06:15 2012 +0900

        Process new git revisions all at once rather than per

    commit 21a480dd6e08f3c3cce54e1d6ee4c05b0dd59daa
    Author: test
    Date:   Fri Mar 16 19:06:14 2012 +0900

        Pass revisions to git-log via stdin

    $ git format-patch -k --stdout 21a480dd6e08f^..3137eff804b0fc35 > example-mbox-git.diff
