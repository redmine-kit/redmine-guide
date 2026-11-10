---
source: RedmineMigrate
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineMigrate
source_version: 34
source_updated_on: '2020-07-30T13:12:27Z'
---

# Migrating from other systems

## Trac

**Obsolete: Does not work**

The Trac importer migrates:

- Users
- Components
- Milestones
- Tickets
- Ticket comments and changes (status and resolution)
- Trac specific fields (eg. Resolution) are added as custom fields in Redmine
- Ticket files and custom fields
- Wiki pages with history

Notes:

1.  User passwords are all set to `trac`
2.  Ticket ids are preserved if there’s no ticket in your Redmine database yet
3.  Custom fields are all created as text custom fields in Redmine

You need the sqlite-ruby gem to access the Trac database.

\- For sqlite: `gem install sqlite-ruby`\
- For sqlite3: `gem install sqlite3-ruby`

Before starting, you need a fresh Redmine database, **with default data loaded (required)**. See [Redmine installation](install.md).

The script was tested with a 0.10 Trac sqlite database and a 0.11 Trac sqlite3 database.

1\. Run the following command, where test is your Redmine target environment:

rake redmine:migrate_from_trac RAILS_ENV=”test”

2\. The script ([source:trunk/lib/tasks/migrate_from_trac.rake](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/tasks/migrate_from_trac.rake)) asks you for your Trac settings:

```text
Trac directory []: /var/trac/myproject
Trac database adapter (sqlite, sqlite3, mysql, postgresql) [sqlite]:
Database encoding [UTF-8]:
Target project identifier []: myproject
```

Trac directory is the root directory of your Trac environment. Redmine will look in this directory for `db/trac.db` (if you choose sqlite/sqlite3 database) and the `attachments` directory.\
When using a mysql or postgresql Trac database, the script will ask you for the connection parameters (host, database name, username and password).\
Target project identifier is the identifier of the Redmine project in which the data will be loaded (the project is created if not found).

3\. The script migrates your data:

```text
Deleting data
Migrating components..............................
Migrating milestones..............
Migrating custom fields.......
Migrating tickets.................................
Migrating wiki...........

Components: 29/30
Milestones: 14/14
Tickets: 1275/1275
Ticket files: 106/106
Custom values: 4409/4409
Wiki edits: 102/102
```

The script gives you the total number of migrated objects.\
Now, you should see a project called Myproject in Redmine with your Trac data loaded in this project.

## Mantis

**Obsolete: Does not work**

The Mantis importer migrates:

- Users
- Projects
- Project versions, categories and news
- Project memberships
- Bugs
- Bug notes, files, relations and monitors
- Custom fields

User passwords are all set to “mantis”.

Bug files migration only works if they’re stored in your Mantis database (this is the default Mantis behaviour).

The script was tested with different 1.0.x Mantis databases and should work with any other recent versions.

Before starting, you need a fresh Redmine database, **with default data loaded (required)**. See [Redmine installation](install.md).\
When migrating into filled Redmine database, you can use [Ulrichs](email://uk@fortrabbit.de) [Non-destructive migration Script](http://blog.foaa.de/2010/04/non-destructive-migration-from-mantis-to-redmine/)

Make sure to apply the patch [#10504](https://www.redmine.org/issues/10504).

1\. Run the following command, where test is your Redmine target environment:

rake redmine:migrate_from_mantis RAILS_ENV=”test”

2\. The script asks you for your Mantis database settings:

```text
Please enter settings for your Mantis database
adapter [mysql]:
host [localhost]:
database [bugtracker]: mantis
username [root]:
password []:
encoding [UTF-8]:
```

Give the adapter, host name, database name, login, password and encoding of your Mantis database, or leave the default values.

The adapter can be mysql (default) or postgresql.

3\. The script migrates your data:

```text
Migrating users...............
Migrating projects.............
Migrating bugs........................................
Migrating news...
Migrating custom fields..

Users: 15/15
Projects: 13/13
Memberships: 10/10
Versions: 33/33
Categories: 4/4
Bugs: 180/180
Bug notes: 336/336
Bug files: 46/46
Bug relations: 11/11
Bug monitors: 8/8
News: 3/3
Custom fields: 2/2
```

The script gives you the total number of migrated objects.

## Other systems and third-party scripts

You can find other importers created by Redmine users:

- [Non-destructive migration from Mantis to Redmine](http://blog.foaa.de/2010/04/non-destructive-migration-from-mantis-to-redmine/)

<blockquote>

- No support anymore

</blockquote>

- Jira importer: [#1385](https://www.redmine.org/issues/1385)
- Bugzilla importer: [#989](https://www.redmine.org/issues/989) There are currently two bugzilla importers. bz2redmine http://github.com/ralli/bz2redmine and migrate_from_bugzilla http://github.com/ralli/migrate_from_bugzilla. The bz2redmine preserves the original bugzilla bug numbers and the migrate_from_bugzilla rake task uses the ActiveRecord framework and may be used to migrate from and to postgresql databases.
- Scarab importer: [#2928](https://www.redmine.org/issues/2928)
- Migrate projects from another instance of Redmine: https://github.com/PowerKiKi/redmine-tools\
  -\* [A trick to import data from Mantis](http://dotnetmarche.org/blogs/externalblogs/archive/2009/05/29/redmine-a-trick-to-import-data-from-mantis.aspx-)
- Migrate phpBugTracker-1.0.5 to Redmine 2.5: https://github.com/ottodude125/migrate_from_phpbt_to_redmine - Though not exact, this shares some similarities to the Mantis import script

These scripts are neither tested nor supported.
