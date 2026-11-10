---
source: RedmineInstall
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineInstall
source_version: 356
source_updated_on: '2026-07-07T21:44:14Z'
---

# Installing Redmine

This is the installation documentation for Redmine 6.0 and higher. You can still read the document for older versions: [4.0 - 5.1](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/352), [3.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/308) , [1.4.x - 2.6.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/263), [1.3.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall?version=146)

## Requirements

### Operating system

Redmine should run on most Unix, Linux, [macOS](https://www.redmine.org/projects/redmine/wiki/RedmineInstallOSX) and [Windows](install.md#Notes-on-Windows-installation) systems as long as Ruby is available on this platform. See specific installation HowTos [here](https://www.redmine.org/projects/redmine/wiki/HowTos).

### Ruby interpreter and supported databases

The required Ruby versions and supported database back-ends for a given Redmine version are:

<table>
<thead>
<tr>
<th rowspan="2" style="vertical-align: middle;">Redmine version</th>
<th rowspan="2" style="vertical-align: middle;">Supported Ruby versions<sup>1</sup></th>
<th rowspan="2" style="vertical-align: middle;">Rails version used</th>
<th colspan="4" style="text-align: center;">Recommended Databases</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>PostgreSQL</strong></td>
<td><strong>MySQL</strong></td>
<td><strong>MSSQL</strong></td>
<td><strong>SQLite</strong></td>
</tr>
<tr>
<td>trunk</td>
<td>Ruby 3.2, 3.3, 3.4, 4.0<sup>1</sup></td>
<td>Rails 8.1</td>
<td>14</td>
<td>8.0 - 8.4<sup>2</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>7.0</td>
<td>Ruby 3.2, 3.3, 3.4, 4.0<sup>1</sup></td>
<td>Rails 8.1</td>
<td>14</td>
<td>8.0 - 8.4<sup>2</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>6.1</td>
<td>Ruby 3.2, 3.3, 3.4</td>
<td>Rails 7.2</td>
<td>14</td>
<td>8.0 - 8.4<sup>2</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>6.0</td>
<td>Ruby 3.1, 3.2, 3.3</td>
<td>Rails 7.2</td>
<td>14</td>
<td>8.0 - 8.1<sup>2</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
</tbody>
</table>

<sup>1</sup> Some older supported Ruby versions may have reached end of life. For the current maintenance status of each Ruby version, see https://www.ruby-lang.org/en/downloads/branches/

<sup>2</sup> Ruby versions 4.0.0 to 4.0.3 have a significant wiki rendering slowdown caused by a regression in the Ruby runtime itself (#43737, tracked upstream at bugs.ruby-lang.org \#21856). This was fixed upstream in Ruby 4.0.4, so we recommend running Redmine 7.0 on Ruby 4.0.4 or later.

<sup>3</sup> **MySQL** requires to change the `transaction_isolation` to `READ COMMITTED` in order to properly work [MySQL_configuration](mysql-configuration.md).

Important notices:

- **Redmine does not support JRuby**.
- Microsoft SQL Server [2012 or higher](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/blob/v4.2.3/README.md#activerecord-sql-server-adapter-for-sql-server-2012-and-higher)
- SQLite 3 (not for multi-user production use!)

### Optional components

- SCM binaries (eg. `svn`), for repository browsing (must be available in your PATH). See [RedmineRepositories](../admin/repositories.md) for SCM compatibility and requirements.
- [ImageMagick](http://www.imagemagick.org/) (to enable Gantt export to PNG image and thumbnails generation).
- [Ghostscript](https://www.ghostscript.com/) (to enable thumbnails generation for PDF attachments).
- [Pandoc](https://pandoc.org/) (to enable previews of Microsoft Office (.docx, .xlsx, .pptx) documents and LibreOffice Writer documents (.odt) documents in Redmine 7.0 or later. Version 3.8.3 or later is recommended. Earlier versions of Pandoc supports only .docx and .odt documents).
- [Sidekiq](https://github.com/sidekiq/sidekiq), recommended queue backend system for production environment.

## Redmine Version

It is recommended that the majority of users install the proper point releases of redmine. Redmine currently releases a new version every 6 months, and these releases are considered very usable and stable. It is **not** recommended to install redmine from trunk, unless you are deeply familiar with Ruby on Rails and keep up with the changes - Trunk *does* break from time-to-time.

## Installation procedure

### Step 1 - Redmine application

Download a released package and extract it to an appropriate destination on your system.\
As an alternative one can checkout the files directly from the version control system.

Please visit the [download page](download.md) for further information on how to download Redmine.

### Step 2 - Create an empty database and accompanying user

Redmine database user will be named `redmine` hereafter but it can be changed to anything else.

#### MySQL

```sql
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'my_password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
```

#### PostgreSQL

```sql
CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'my_password' NOINHERIT VALID UNTIL 'infinity';
CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;
```

#### SQLite

Skip this step. A database file will be created during [Step 6](install.md#Step-6-Database-schema-objects-creation).

#### SQL Server

The database, login and user can be created within SQL Server Management Studio with a few clicks.

If you prefer the command line option with `SQLCMD`, here’s some basic example:

<details>
<summary>Show SQL</summary>

```sql
USE [master]
GO

-- Very basic DB creation
CREATE DATABASE [REDMINE]
GO

-- Creation of a login with SQL Server login/password authentication and no password expiration policy
CREATE LOGIN [REDMINE] WITH PASSWORD=N'redminepassword', DEFAULT_DATABASE=[REDMINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

-- User creation using previously created login authentication
USE [REDMINE]
GO
CREATE USER [REDMINE] FOR LOGIN [REDMINE]
GO
-- User permissions set via roles
EXEC sp_addrolemember N'db_datareader', N'REDMINE'
GO
EXEC sp_addrolemember N'db_datawriter', N'REDMINE'
GO
```

</details>

### Step 3 - Database connection configuration

Copy `config/database.yml.example` to `config/database.yml` and edit this file in order to configure your database settings for “production” environment. For MySQL, please read this guide as well [MySQL_configuration](mysql-configuration.md).

Example for a MySQL database (default port):

```yml
production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: redmine
  password: "my_password"
  variables:
    transaction_isolation: "READ-COMMITTED"
```

If your server is not running on the standard port (3306), use this configuration instead:

```yml
production:
  adapter: mysql2
  database: redmine
  host: localhost
  port: 3307
  username: redmine
  password: "my_password"
  variables:
    transaction_isolation: "READ-COMMITTED"
```

Example for a PostgreSQL database (default port):

```yml
production:
  adapter: postgresql
  database: <your_database_name>
  host: <postgres_host>
  username: <postgres_user>
  password: "<postgres_user_password>"
  encoding: utf8
  schema_search_path: <database_schema> (default - public)
```

Example for a SQLite database:

```yml
production:
  adapter: sqlite3
  database: db/redmine.sqlite3
```

Example for a SQL Server database (default host `localhost`, default port `1433`):

```yml
production:
  adapter: sqlserver
  database: redmine
  username: redmine # should match the database user name
  password: "redminepassword" # should match the login password
```

### Step 4 - Dependencies installation

Redmine uses [Bundler](http://gembundler.com/) to manage gems dependencies. You can install all the gems required by Redmine using the following command:

    bundle config set --local without 'development test'
    bundle install

#### Optional dependencies

##### Database adapters

Redmine automatically installs the adapter gems required by your database configuration by reading it from the `config/database.yml` file (eg. if you configured only a connection using the `mysql2` adapter, then only the `mysql2` gem will be installed).

Don’t forget to re-run `bundle install --without development test ...` after adding or removing adapters in the `config/database.yml` file!

##### Queues adapter

Redmine uses `ActiveJob::QueueAdapters::AsyncAdapter` as default queue adapter which is [not recommended](https://api.rubyonrails.org/classes/ActiveJob/QueueAdapters/AsyncAdapter.html) for production environment. Recommended adapter is [Sidekiq](https://github.com/sidekiq/sidekiq) which uses Redis for persistance. Configuration guide: [SidekiqConfiguration](https://www.redmine.org/projects/redmine/wiki/SidekiqConfiguration).

#### Additional dependencies (`Gemfile.local`)

If you need to load gems that are not required by Redmine core (eg. Puma, fcgi), create a file named `Gemfile.local` at the root of your redmine directory. It will be loaded automatically when running `bundle install`.

Example:

    # Gemfile.local
    gem 'puma'

### Step 5 - Session store secret generation

This step generates a random key used by Rails to encode cookies storing session data thus preventing their tampering.\
Generating a new secret token invalidates all existing sessions after restart.

    bundle exec rake generate_secret_token

Alternatively, you can store this secret in config/secrets.yml:\
http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml

### Step 6 - Compile assets (optional)

This step is optional and contains instructions to compile the assets such as stylesheets, javascripts and images into the `public/assets` directory for web server delivery.

By default, Redmine automatically recompiles assets in production mode when the application starts. This behavior can be controlled using the `config.assets.redmine_detect_update` flag in the configuration file.

If automatic compilation is disabled or there are issues with the generated assets (including the assets provided by plugins or custom themes), the assets can be manually updated:

using: `bin/rails assets:precompile RAILS_ENV="production"`

If deploying to a sub-uri, set the relative URL root as follows: `bin/rails assets:precompile RAILS_ENV="production" RAILS_RELATIVE_URL_ROOT=/sub-uri`

If you experience issues with missing assets in the browser, try removing the public/assets directory before re-running the precompile:`bin/rails assets:clobber RAILS_ENV="production"`

### Step 7 - Database schema objects creation

Create the database structure, by running the following command under the application root directory:

    RAILS_ENV=production bundle exec rake db:migrate

**Windows syntax:**

    set RAILS_ENV=production
    bundle exec rake db:migrate

It will create tables by running all migrations one by one then create the set of the permissions and the application administrator account, named `admin`.

### Step 8 - Database default data set

Insert default configuration data in database, by running the following command:

RAILS_ENV=production bundle exec rake redmine:load_default_data

Redmine will prompt you for the data set language that should be loaded; you can also define the `REDMINE_LANG` environment variable before running the command to a value which will be automatically and silently picked up by the task.

E.g.:

Unices:

RAILS_ENV=production REDMINE_LANG=fr bundle exec rake redmine:load_default_data

Windows:

    set RAILS_ENV=production
    set REDMINE_LANG=fr
    bundle exec rake redmine:load_default_data

### Step 9 - File system permissions

NB: *Windows users can skip this section.*

The user account running the application must have write permission on the following subdirectories:

1.  `files` (storage of attachments)
2.  `log` (application log file `production.log`)
3.  `tmp` and `tmp/pdf` (create these ones if not present, used to generate PDF documents among other things)
4.  `public/assets` (all assets)

E.g., assuming you run the application with a redmine user account:

    mkdir -p tmp tmp/pdf public/assets
    sudo chown -R redmine:redmine files log tmp public/assets
    sudo chmod -R 755 files log tmp public/assets

Note: If you have files in these directories (e.g. restore files from backup), make sure these files are not executable.

    sudo find files log tmp public/assets -type f -exec chmod -x {} +

### Step 10 - Test the installation

Test the installation by running Puma web server:

    bundle exec rails server -e production

### Step 11 - Logging into the application

Use default administrator account to log in:

- login: admin
- password: admin

You can go to Administration menu and choose Settings to modify most of the application settings.

## Configuration

Redmine settings are defined in a file named `config/configuration.yml`.

If you need to override default application settings, simply copy `config/configuration.yml.example` to `config/configuration.yml` and edit the new file; the file is well commented by itself, so you should have a look at it.

These settings may be defined per Rails environment (`production`/@development@/@test@).

<u>Important</u> : don’t forget to restart the application after any change.

### Email / SMTP server settings

Email configuration is described in a [dedicated page](email-configuration.md).

### SCM settings

This configuration section allows you to:

- override default commands names if the SCM binaries present in the `PATH` variable doesn’t use the standard name (Windows .bat/.cmd names won’t work)
- specify the full path to the binary

Examples (with Subversion):

Command name override:

scm_subversion_command: “svn_replacement.exe”

Absolute path:

scm_subversion_command: “C:\Program Files\Subversion\bin\svn.exe”

### Attachment storage settings

You can set a path where Redmine attachments will be stored which is different from the default ‘files’ directory of your Redmine instance using the `attachments_storage_path` setting.

Examples:

attachments_storage_path: /var/redmine/files

attachments_storage_path: D:/redmine/files

## Logging configuration

Redmine defaults to a log level of :info, writing to the `log` subdirectory. Depending on site usage, this can be a lot of data so to avoid the contents of the logfile growing without bound, consider rotating them, either through a system utility like `logrotate` or via the `config/additional_environment.rb` file.

To use the latter, copy `config/additional_environment.rb.example` to `config/additional_environment.rb` and add the following lines. Note that the new logger defaults to a high log level and hence has to be explicitly set to `info`.

```ruby
#Logger.new(PATH,NUM_FILES_TO_ROTATE,FILE_SIZE)
config.logger = Logger.new('/path/to/logfile.log', 2, 1000000)
config.logger.level = Logger::INFO
```

## Backups

Redmine backups should include:

- data (stored in your redmine database)
- attachments (stored in the `files` directory of your Redmine install)

Please refer to [Backing up and restoring Redmine](https://www.redmine.org/projects/redmine/wiki/RedmineBackupAndRestore) for more details.

## Notes on Linux/Unix installation

Be sure to disable security hardenning tools during the installation process if you run into bizarre permission problems. These problems are mostly silent and can be caused by tools like extended ACLs, SELinux, or AppArmor. There tools are mostly used in big companies with a strict security policy, default Linux/Unix distributions settings shouldn’t be a problem.

## Notes on Windows installation

There is an prebuilt installer of Ruby MRI available from http://rubyinstaller.org.\
After installing it, select *Start Command Prompt with Ruby* in the start menu.

<u>Specifying the `RAILS_ENV` environment variable:</u>

When running command as described in this guide, you have to set the `RAILS_ENV` environment variable using a separate command.

I.e. commands with the following syntaxes:

    RAILS_ENV=production <any commmand>

    <any commmand> RAILS_ENV=production

have to be turned into 2 subsequent commands:

    set RAILS_ENV=production
    <any commmand>

<u>MySQL gem installation issue:</u>

You may need to manually install the mysql gem using the following command:

    gem install mysql

And in some case it is required to copy the *libmysql.dll* file in your ruby/bin directory.\
Not all libmysql.dll are ok this seem to works http://instantrails.rubyforge.org/svn/trunk/InstantRails-win/InstantRails/mysql/bin/libmySQL.dll.

**Important note for Win7 and later**\
On Win7 and later, `localhost` is commented out in the hosts file<sup>5</sup> and IPV6 is the default<sup>6</sup>. As the mysql2 gem does no support IPV6 addresses<sup>7</sup>, a connection can’t be established and you get the error “`Can't connect to MySQL server on 'localhost' (10061)`”.\
You can confirm this by pinging `localhost`, if ping targets “::1:” IPV6 is being used.

<u>Workaround:</u>\
Replace `localhost` with `127.0.0.1` in database.yml.

<sup>5</sup> http://serverfault.com/questions/4689/windows-7-localhost-name-resolution-is-handled-within-dns-itself-why

<sup>6</sup> http://www.victor-ratajczyk.com/post/2012/02/25/mysql-fails-to-resolve-localhost-disable-ipv6-on-windows.aspx

<sup>7</sup> https://github.com/brianmario/mysql2/issues/279

## Alternative to manual installation

Some users may prefer to skip manual installation by using one of the [third-party Redmine bundles](download.md#Third-party-Redmine-bundles) on the download page.
