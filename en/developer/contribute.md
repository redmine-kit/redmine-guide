---
source: Contribute
source_url: https://www.redmine.org/projects/redmine/wiki/Contribute
source_version: 53
source_updated_on: '2015-12-18T14:11:59Z'
updated_for: 7.0.3
---

# Contribute

Redmine is built and maintained by community volunteers. If you enjoy using Redmine and would like give back to the community, there are several ways to contribute back to the project. Also read the [How to contribute](https://www.redmine.org/boards/1/topics/4325) forum thread for some more specific ideas.

## Contributors

The [Teams](https://www.redmine.org/projects/redmine/wiki/Teams) page gives an overview of the different roles.\
Check the Member list in the [Overview page](http://www.redmine.org/projects/redmine) to get the complete list of Redmine’s current contributors and authors.\
You can also follow code activity via the [Repository Statistics page](http://www.redmine.org/projects/redmine/repository/statistics).

## Code Related

These require a familiarity with Ruby on Rails development. If you are still new to Rails, Community members can help you if you get stuck with something or have any other questions.

You will need to download a copy of the current development-code. The official code repository is located in Subversion and can be downloaded by following the [Download](../install/download.md) instructions.

A copy of the source is mirrored to [Bitbucket](https://bitbucket.org/redmine) (this is maintained by the community) and [GitHub](http://github.com/redmine/redmine) (this is maintained by the community), if you would like to use Mercurial and Git for development.

Any questions can be asked in the [Forums](http://www.redmine.org/projects/redmine/boards/1) or to the [Development Team](https://www.redmine.org/projects/redmine/wiki/Teams) on IRC.

### Patch checking

Fixing outdated patches so they can apply cleanly to the latest code is very helpful. Many issues will have patches but they will not run on latest version.

See the [Patch Queue](http://www.redmine.org/projects/redmine/issues?query_id=931) for the list of open patches.\
“Patch” is Redmine.org custom [Tracker](../admin/issue-tracking-setup.md#Trackers) for Issues containing patches

### Code documentation

Documenting classes and methods using [RDoc](http://rdoc.sourceforge.net/) will help developers understand how Redmine works better. Once you have a copy of Redmine installed, running `bin/rake yard` will generate the latest documentation (YARD) in `doc/app`. Patches for methods without documentation or with poor documentation would be helpful and an easy way to contribute. [List of documentation issues](http://www.redmine.org/projects/redmine/issues?query_id=84*)\*

### Development

Patches to fix bugs or add new features are always appreciated. If you are going to work on a specific issue, make a note in the issue details so the developers will know what you’re working on.

### Basic process for contributing code:

1.  Make sure you are working on the **svn trunk** or **mercurial default named branch** or **git master branch**.\
    Patches are not accepted for stable releases because someone would have to port a patch to trunk first and then port it back to stable (i.e. double the work).\
    If you use mercurial, you can use [graft](http://www.selenic.com/hg/help/graft) or [mercurial queues extension](http://mercurial.selenic.com/wiki/MqExtension) .
2.  Redmine has **tests** ([source:trunk/test](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/test)). Make sure all the existing tests pass. You can check the current build statuses on the [Redmine Continuous Integration server](https://www.redmine.org/projects/redmine/wiki/Continuous_integration). You can run “rake test” for entire tests or “ruby test/unit/issue_test.rb” for an each test. For more details, see [source:trunk/doc/RUNNING_TESTS](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/doc/RUNNING_TESTS)
3.  Add tests to show the new functionality and check for bugs
4.  Post the patch to the issue.\
    **<span style="color: red">Do not send a pull request on GitHub and Bitbucket</span>**.\
    If you use Mercurial or Git, you can create patch series.\
    See [How to create patch series on Mercurial and Git](how-to-create-patch-series-on-mercurial-and-git.md)
5.  Ask for feedback from users and developers. Users will want to to apply the patch and try out the new functionality. Developers will want to do a code review and run all of the tests.
6.  Discuss any changes that are proposed and post new patches as needed

## Non Code Related

These don’t require any software development experience, just time and the desire to help.

### User support

Helping out other users in the [Forums](http://www.redmine.org/projects/redmine/boards) and the IRC channel (#redmine @ freenode) is always useful. Frequent problems or questions should be brought up so the wiki can be updated to help future users.

### Localization support

[Translations](https://www.redmine.org/projects/redmine/wiki/HowTo_translate_Redmine_in_your_own_language) should be kept up-to-date alongside the development of Redmine. You could provide updates of the translations where necessary or proposed to support Redmines I18n-support. [List of Localization and Translation issues](http://www.redmine.org/projects/redmine/issues?query_id=7*)\*

### Issue triage

Sometimes issues are reported without all the [information needed by a developer](submissions.md#Submitting-a-Bug). Getting the details of the bug or feature from the reporter and the community will help everyone understand what is needed. If you can also try to reproduce the bug in your own Redmine, adding a note about your Redmine version and the exact steps you took are extremely useful.

### Design and User interface

Redmine uses a very basic design and user interface. Any improvements to it including new themes, skinning, or interface adjustments could help every user of Redmine. Get involved with the [UI / UX Team](https://www.redmine.org/projects/redmine/wiki/UX_Team).
