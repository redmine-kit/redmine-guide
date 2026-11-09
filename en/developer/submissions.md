---
source: Submissions
source_url: https://www.redmine.org/projects/redmine/wiki/Submissions
source_version: 30
source_updated_on: '2024-04-02T16:50:30Z'
---

# Submissions on redmine.org

Submissions should be written in English.

## Submitting a Bug

Before submitting a bug report here, please make sure:

- that you’re using an appropriate Rails version (see [RedmineInstall](../install/install.md))
- that your database is up to date, especially if you’ve just migrated from a previous version or revision (see [RedmineUpgrade](../install/upgrade.md))
- if your problem is related to svn (or any other scm), that the proper binaries are installed on your Redmine host (see [RedmineRepositories](../admin/repositories.md))

And have a look at the [bug list](http://www.redmine.org/projects/redmine/issues?query_id=1) and the [FAQ](https://www.redmine.org/projects/redmine/wiki/FAQ) to see if it has not already been reported.

When filling a bug report, please give the following information with the description of your problem:

- your database manager version (e.g. PostgreSQL 9.2)
- your Ruby version (e.g. Ruby 3.2.2)
- your Redmine version (pick the version number in the *Affected version* field) and the exact revision (eg. r22769) if you’re using repository code
- your scm binary version (e.g. svn 1.14.3, or git 2.44.0) if your problem is about scm integration
- your using plugins (eg. Code Review plugin)

The simplest way to get information about your environment is to run the following command from within your Redmine installation:

    ruby bin/about

When reporting an application error, post the full error stack trace that you should find in the log file (eg. `log/production.log`). The message displayed by the application (eg. *…An error occurred on the page you were trying to access…*) is useless here.

If the error you’re reporting occurs when running a rake task (example: `rake db:migrate`), rerun the task with the `--trace` option (example: `rake db:migrate --trace`) and post the full output.

If you have installed Redmine using an external package manager, such as the `redmine` package on Debian/Ubuntu, a Bitnami VM, or a pre-built Docker image, please contact the support channels for these package manager instead unless you are very sure that the issue is specifically caused by Redmine itself. These packages are not maintained by the Redmine team. Often, they have custom changes applied or require specific setup steps which we do not known and generally can’t help you with.

## Submitting a Security Vulnerability

If you think that you’ve found a security vulnerability, please report it by sending an email to: `security(at)redmine.org`. Known vulnerabilities that were fixed in Redmine releases are listed on the [Security Advisories](https://www.redmine.org/projects/redmine/wiki/Security_Advisories).

## Submitting a Feature Request

Before submitting a feature request here, please make sure:

- fill the *subject* as a sum up of your description
- fill the *description* as detailed as you can, don’t hesitate to describe precisely how this feature should behave, try to add what benefits you’re excepting from it
- please **DON’T** fill the *target version* field: let the developers decide when integrate
- please **DON’T** assign the feature request to anybody, let the developers deal with it

## Submitting a Wiki improvement

When you edit a wiki page to improve its content, make sure that you fill the *comment* field with a descriptive summary of the changes you’ve made to the page. This way we’ll be better able to “monitor” and “maintain” the quality of the actual wiki content.

## Submitting a Patch

- Changes should be submitted as a single patch file. Instructions for creating a patch using svn can be found [here](patch.md).
- You should mention the branch/revision your patch is based on and attach it
