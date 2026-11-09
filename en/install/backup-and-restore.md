---
source: RedmineBackupRestore
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineBackupRestore
source_version: 14
source_updated_on: '2025-02-01T09:47:37Z'
---

# Backing up and restoring Redmine

## Backup

Redmine backups should include:

- Database
- Attachments (stored in the `files` directory under the installation directory by default)

### Backing up database

#### MySQL

The `mysqldump` command can be used to backup the contents of your MySQL database to a text file. For example:

    /usr/bin/mysqldump -u <username> -p<password> -h <hostname> <redmine_database> > /path/to/backup/db/redmine.sql

You can find `<username>`, `<password>`, `<hostname>`, and `<redmine_database>` in the file `config/database.yml`. `<host_name>` may not be required depending on your installation of the database.

#### PostgreSQL

The `pg_dump` command can be used to backup the contents of a PostgreSQL database to a text file. Here is an example:

    /usr/bin/pg_dump -U <username> -h <hostname> -Fc --file=redmine.sqlc <redmine_database>

You can find `<username>`, `<hostname>`, and `<redmine_database>` in the file `config/database.yml`. `<hostname>` may not be required depending on your installation of the database. The `pg_dump` command will prompt you to enter the password when necessary.

#### SQLite

SQLite databases are all contained in a single file, so you can back them up by copying the file to another location.

You can determine the file name of SQLite database by looking at `config/database.yml`.

### Backing up attachments

All file uploads are stored in `attachments_storage_path` (defaults to the `files/` directory). You can copy the contents of this directory to another location to easily back it up.

<u>WARNING:</u> `attachments_storage_path` may point to a different directory other than `files/`. Be sure to check the setting in `$RAILS_ROOT/config/configuration.yml` to avoid making a useless backup.\
This file may not exist (status: Redmine v5.0.4), it exists a template `$RAILS_ROOT/config/configuration.yml.example` to change\
the standard values, copy this file and rename it to `$RAILS_ROOT/config/configuration.yml`.\
In my installation via Debian package, the attached files are stored in\
`/var/lib/redmine/default/files`.\
You can find this folder by file search, attach a file to wiki-page or add a document to a project and look for “\*\_filename.filextention”, in my case the stored file start with 12 digits: \<`yymmddhhmmss`\>.\
Interesting is also where the file `Gemfile.lock` is located, for me it was two levels above in the folder hierarchy: `/var/lib/redmine/`\
Keep also in mind, you may you have plugins installed that my have a different storage location, in my case it is the plugin [DMSF](https://www.redmine.org/plugins/redmine_dmsf).

### Sample backup script

Here is a simple shell script that can be used for daily backups (assuming you’re using a MySQL database):

    # Database
    /usr/bin/mysqldump -u <username> -p<password> <redmine_database> | gzip > /path/to/backup/db/redmine_`date +%Y-%m-%d`.gz

    # Attachments
    rsync -a /path/to/redmine/files /path/to/backup/files

## Restore

### Restoring a database

#### MySQL

For example if you have a gziped dump file with the name `2018-07-30.gz`, then the database can be restored with the following command:

    gunzip -c 2018-07-30.gz | mysql -u <username> --password <redmine_database>
    Enter password:

#### PostgreSQL

When the option `-Fc` of the command `pg_dump` is used like it is at the above example then you need to use the command `pg_restore`:

    pg_restore -U <username> -h <hostname> -d <redmine_database> redmine.sqlc

otherwise a text file can be restored with `psql`:

    psql <redmine_database> < <infile>

#### SQLite

Copy the database file from the backup location.
