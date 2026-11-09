---
source: RedmineUpgrade
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineUpgrade
source_version: 84
source_updated_on: '2022-12-24T07:36:25Z'
---

# Upgrading

The documentation below is based on upgrading to Redmine 2.x and higher. You can view a previous version for upgrading to Redmine 1.x [here](https://www.redmine.org/projects/redmine/wiki/RedmineUpgrade?version=53).

## Step 1 - Check requirements

The first step to upgrading Redmine is to check that you meet the [requirements](install.md#Requirements) for the version you’re about to install.

## Step 2 - Backup

It is recommended that you backup your database and file uploads. Most upgrades are safe but it never hurts to have a backup just in case.

To understand how to back up your Redmine, please read [Backing up and restoring Redmine](https://www.redmine.org/projects/redmine/wiki/RedmineBackupAndRestore).

## Step 3 - Perform the upgrade

Now it’s time to perform the actual upgrade. This process is different depending on how you downloaded Redmine. You only need to perform **one** of the following options.

### Option 1 - Download a stable release

1\. [Download](download.md) the release in either tar.gz or zip format and uncompress the new program archive in a new directory.

Make sure the newly extracted and copied files and directories have the correct owner and group set, so that the user/group running your application server can actually access the files.\
Also, remember to add write permissions to the `files`, `log` and `tmp` directory.

2\. Copy your database settings-file `config/database.yml` into the new `config` directory. If you’re running Redmine \>= 1.4 with mysql and ruby1.9, change the database adapter to \`mysql2\`.

3a. Copy your base configuration settings-file `config/configuration.yml` into the new `config` directory.

3b. Or, **if upgrading from version older than 1.2.0**, copy your email settings from your `config/email.yml` into the new `config/configuration.yml` file that can be created by copying the available `configuration.yml.example` file.

4\. Copy the `files` directory content into your new installation (this directory contains all your uploaded files).

5\. Copy the folders of your **custom** plugins from your `plugins` directory (or `vendor/plugins` directory if upgrading from a 1.x version) into new installation `plugins` directory. Make sure that you copy only plugins that are were not initially bundled with your previous Redmine setup.

6\. Install the required gems by running:

    bundle config set --local without 'development test'
    bundle install

Only the gems that are needed by the adapters you’ve specified in your database configuration file are actually installed (eg. if your config/database.yml uses the ‘mysql2’ adapter, then only the mysql2 gem will be installed). Don’t forget to re-run \`bundle install\` when you change config/database.yml for using other database adapters.

If you need to load some gems that are not required by Redmine core (eg. fcgi), you can create a file named Gemfile.local at the root of your redmine directory. It will be loaded automatically when running \`bundle install\`.

7\. Run the following command from your new Redmine root directory:

If you’re upgrading from Redmine 2.x or below, remove the following file if it exists:

- config/initializers/secret_token.rb

Then generate a new secret by running the following command under the application directory:

bundle exec rake generate_secret_token

Alternatively, you can store this secret in config/secrets.yml:\
http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml

8\. Check for any themes that you may have installed in the `public/themes` directory. You can copy them over but checking for updated version is ideal.

VERY IMPORTANT: do NOT overwrite `config/settings.yml` with the old one.

### Option 2 - Upgrading from a SVN checkout

1\. Go to the Redmine root directory and run the following command:

    svn update

2\. Install the required gems by running the following command:

bundle update

## Step 4 - Update the database

This step is the one that could change the contents of your database. Go to your new redmine directory, then migrate your database:

    bundle exec rake db:migrate RAILS_ENV=production 

If you have installed any plugins, you should also run their database migrations:

    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

## Step 5 - Clean up

1\. Clear the cache:

bundle exec rake tmp:cache:clear RAILS_ENV=production

2\. Restart the application server (e.g. puma, thin, passenger)

3\. Finally go to *“Admin -\> Roles & permissions”* to check/set permissions for the new features, if any.

## Common issues

### Errors with repository management

There were several new features added to the reposman.rb file, make sure you have a group specified if you’re having issues ( —group=groupnamehere). Also, make sure you follow the instructions [here](https://www.redmine.org/projects/redmine/wiki/Repositories_access_control_with_apache_mod_dav_svn_and_mod_perl) again if you only copied your Redmine.pm, and update your Apache configuration as the recommended configuration has changed.

### Generating a new `secret_token.rb`

Before version:2.0.0, a `session_store.rb` file needed to be generated in Redmine’s `config` directory for the cookie based sessions to work.

Starting from version:2.0.0, the `session_store.rb` file should not exist. Instead, the following command will generate the `secret_token.rb` file:

bundle exec rake generate_secret_token

*Note: The code repository for Redmine does not contain the config/initializers/secret_token.rb file, it is created by the above rake command.*

### Related Resources

These resources may help you with your Redmine upgrade:

- Error while browsing the wiki history after upgrading from Redmine 1.x with SQLite: see \[#12501](https://www.redmine.org/issues/12501)
- [mod_fcgid for Apache2](http://httpd.apache.org/mod_fcgid/) helped us get Rails running on Apache 2
- [Running Redmine on Apache](http://www.redmine.org/wiki/redmine/HowTo_configure_Apache_to_run_Redmine)
- [Notes about our 0.8.6 to 0.9.3 upgrade issues and how to resolve them](http://web.archive.org/web/20111214022108/http://www.cybersprocket.com/2010/project-management/upgrading-redmine-from-8-6-to-9-3/) —cybersprocket (2010-04-25)
- [Notes about our 0.9.6 to 1.0(RC) upgrade process](http://web.archive.org/web/20120610010521/http://www.cybersprocket.com/2010/tips-tricks/upgrading-redmine-from-0-9-6-to-1-0-0/) —cybersprocket (2010-08-14)
