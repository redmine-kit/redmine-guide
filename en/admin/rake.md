---
source: RedmineRake
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineRake
source_version: 13
source_updated_on: '2017-09-12T07:25:12Z'
updated_for: 7.0.3
---

# Rake tasks

<div style="color:red;">

WIP

</div>

Redmine defines a set of [Rake](http://rake.rubyforge.org) tasks for use in maintenance operations.

Information about tasks defined by the Ruby on Rails framework are accessible on [the dedicated page](http://guides.rubyonrails.org/command_line.html#bin-rails).

At any time you can get the full list of tasks using command `rake -T`.

**When running a task** don’t forget to set `RAILS_ENV` variable to production!

E.g. (\*nix style):

rake redmine:permissions RAILS_ENV=production

or (Windows style):

set RAILS_ENV=production\
rake redmine:permissions

## Batch job tasks

### `rake redmine:attachments:prune`

*Applicable starting from version version:2.3.0.*

When a user attaches a file to an issue, a wiki page, etc., the file is immediately uploaded and is attached later on after the form has been submitted.

This task removes uploaded files left unattached (meaning the form has never been submitted) after one day.

### `rake redmine:email:read`

Read an email from standard input.

### `rake redmine:email:receive_imap`

Read emails from an IMAP server.

### `rake redmine:email:receive_pop3`

Read emails from an POP3 server.

### `rake redmine:fetch_changesets`

Fetch changesets from the repositories

### `rake redmine:send_reminders`

Send reminders about issues due in the next days.\
See: [RedmineReminderEmails](reminder-emails.md)

### `rake redmine:tokens:prune`

Removes expired tokens.

### `rake redmine:watchers:prune`

Removes watchers from what they can no longer view.\
Available in versions version:2.3.0

## Other maintenance tasks

### `rake generate_secret_token`

Generates a secret token for the application.

### `rake db:encrypt` and `rake db:decrypt`

Encrypts or decrypts SCM and LDAP passwords stored in the database.

### `rake redmine:attachments:move_to_subdirectories`

Moves attachments stored at the root of the file directory (ie.\
Available in versions version:2.3.0

### `rake redmine:email:test[login]`

Send a test email to the user with the provided login name

### `rake redmine:permissions`

List all permissions and the actions registered with them

### `rake redmine:plugins`

Migrates plugins.

### `rake redmine:plugins:assets`

Redmine 7.0.3 no longer has this task.

### `rake redmine:plugins:migrate`

Migrates installed plugins.

## Migrating from another BTS

### `rake redmine:migrate_from_mantis`

Mantis migration script. This task is no longer maintained and cannot be used in Redmine 7.0.3 (deprecated in Redmine 7.0.0).

### `rake redmine:migrate_from_trac`

Trac migration script. This task is no longer maintained and cannot be used in Redmine 7.0.3 (deprecated in Redmine 7.0.0).
