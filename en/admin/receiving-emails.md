---
source: RedmineReceivingEmails
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineReceivingEmails
source_version: 93
source_updated_on: '2023-07-10T12:31:19Z'
---

# Receiving emails

Redmine can be configured to allow issue creation or comments via email. It is also able to recognize and incorporate email replies to forum messages.

## Setup

You can configure Redmine to receive emails in one of the following ways:

- Forwarding emails from your email server:
  - Pros: works with a remote mail server, email are processed instantly, fast (no environment reloading)
  - Cons: needs some configuration on your mail transfer agent (eg. Postfix, Sendmail…)
- Fetching emails from an IMAP or POP3 server:
  - Pros: easy to setup, no need to configure your MTA, works with a remote mail server
  - Cons: emails are not processed instantly (a cron job needs to be added to read emails periodically)
- Reading emails from standard input:
  - Pros: fine for testing purpose
  - Cons: slow (the environment is reloaded each time an email is read), needs some configuration on your MTA

### Forwarding emails from your email server

A standalone script can be used to forward incoming emails from your mail server.\
This script reads a raw email from the standard input and forwards it to Redmine via a HTTP request.\
It can be found in your redmine directory: `extra/mail_handler/rdm-mailhandler.rb`.

In order to use it, you have to enable the API that receive emails:\
Go to *Application settings* -\> *Incoming emails*, check **Enable WS for incoming emails** and enter or generate a secret key.

Copy `rdm-mailhandler.rb` to your mail server, make sure its permissions allow execution (`chmod +x rdm-mailhandler.rb`), and configure your MTA (Mail Transport Agent).

Usage:

    Usage: rdm-mailhandler.rb [options] --url=<Redmine URL> --key=<API key>

    Required arguments:
        -u, --url URL               URL of the Redmine server
        -k, --key KEY               Redmine API key

    General options:
            --key-file FILE         full path to a file that contains your Redmine
                                    API key (use this option instead of --key if
                                    you don't want the key to appear in the command
                                    line)
            --no-check-certificate  do not check server certificate
            --certificate-bundle FILE
                                    certificate bundle to use
        -h, --help                  show this help
        -v, --verbose               show extra information
        -V, --version               show version information and exit

    User and permissions options:
            --unknown-user ACTION   how to handle emails from an unknown user
                                    ACTION can be one of the following values:
                                    * ignore: email is ignored (default)
                                    * accept: accept as anonymous user
                                    * create: create a user account
            --no-permission-check   disable permission checking when receiving
                                    the email
            --default-group GROUP   add created user to GROUP (none by default)
                                    GROUP can be a comma separated list of groups
            --no-account-notice     don't send account information to the newly
                                    created user
            --no-notification       disable email notifications for the created
                                    user

    Issue attributes control options:
            --project-from-subaddress ADDR
                                    select project from subaddress of ADDR found
                                    in To, Cc, Bcc headers
        -p, --project PROJECT       identifier of the target project
        -s, --status STATUS         name of the target status
        -t, --tracker TRACKER       name of the target tracker
            --category CATEGORY     name of the target category
            --priority PRIORITY     name of the target priority
            --assigned-to ASSIGNEE  assignee (username or group name)
            --fixed-version VERSION name of the target version
            --private               create new issues as private
        -o, --allow-override ATTRS  allow email content to set attributes values
                                    ATTRS is a comma separated list of attributes
                                    or 'all' to allow all attributes to be
                                    overridable (see below for details)

See [Issue-attributes](receiving-emails.md#Issue-attributes) for a list of values that can be used for the `--allow-override` option.

Examples:

      # No project specified. Emails MUST contain the 'Project' keyword:
      rdm-mailhandler.rb --url http://redmine.domain.foo --key secret

      # Fixed project and default tracker specified, but emails can override
      # both tracker and priority attributes:
      rdm-mailhandler.rb --url https://domain.foo/redmine --key secret \\
                         --project foo \\
                         --tracker bug \\
                         --allow-override tracker,priority

Here is an example for a Postfix local alias entry:

    foo: "|/path/to/rdm-mailhandler.rb --url http://redmine.domain --key secret --project foo"

This line should go in the aliases file, which is usually specified in `/etc/aliases`. If the location is unknown, use the command `postconf alias_maps` to find out. After updating the aliases file, be sure to run `newaliases` to alert Postfix of the new entry.

If your domain is setup as a virtual mailbox map (so that you use /etc/postfix/virtual_mailbox_maps to do mappings in the form @ user@example.com /path/example.com/user@) you should:

- create a mapping in `/etc/virtual` like: @ foo@example.org foo@
- modify `/etc/postfix/main.cf` to specify a transport file: `transport_maps = hash:/etc/postfix/transport`
- within the transport file add a line like: @ foo@example.org local:@

**Explanation:** - When you define virtual_mailbox_maps for a domain the default transport is virtual, which means specifying a local alias in `/etc/postfix/virtual` will fail (with “unknown user”). To fix this, we override the default transport by specifying a local transport for the email address in question, which means the local alias will resolve correctly, and your script will be executed.

### Fetching emails from an IMAP server

A rake task (`redmine:email:receive_imap`) can be used to fetch incoming emails from an IMAP server. When you run the rake command from a cron job you can include the switch `-f /path/to/redmine/appdir/Rakefile` on the rake command, because otherwise the rakefile is not found. This is an example line for a cron file that fetches mails every 30 minutes:

    */30 * * * * redmineuser rake -f /path/to/redmine/appdir/Rakefile redmine:email:receive_imap RAILS_ENV="production" host=imap.foo.bar username=redmine@somenet.foo password=xxx

If your setup is working, but you receive mails from the cron daemon, you can suppress the output from the rake command by adding the —silent switch. That should stop cron sending mails on every execution of the command.

    */30 * * * * redmineuser rake -f /path/to/redmine/appdir/Rakefile --silent redmine:email:receive_imap RAILS_ENV="production" host=imap.foo.bar username=redmine@somenet.foo password=xxx

The command has to go on a single line in your cronfile. Also see the other examples below, which only show the rake commands without the `-f` option and without the cron part.

For Windows as server [pycron](http://www.kalab.com/freeware/pycron/pycron.htm) can be used to schedule a fetch task.

It can be necessary that you open the firewall on the machine for outgoing TCP connections to IMAP port 143.

Available IMAP options:

      host=HOST                IMAP server host (default: 127.0.0.1)
      port=PORT                IMAP server port (default: 143)
      ssl=SSL                  Use SSL? (default: false)
      starttls=STARTTLS        Use STARTTLS? (default: false)
      username=USERNAME        IMAP account
      password=PASSWORD        IMAP password
      folder=FOLDER            IMAP folder to read (default: INBOX)
      move_on_success=MAILBOX  move emails that were successfully received
                               to MAILBOX instead of deleting them
      move_on_failure=MAILBOX  move emails that were ignored to MAILBOX

User and permissions options:

      unknown_user=ACTION      how to handle emails from an unknown user
                               ACTION can be one of the following values:
                               ignore: email is ignored (default)
                               accept: accept as anonymous user
                               create: create a user account
      no_permission_check=1    disable permission checking when receiving
                               the email
      no_account_notice=1      disable new user account notification
      default_group=foo,bar    adds created user to foo and bar groups

Issue attributes control options:

      project=PROJECT          identifier of the target project
      project_from_subaddress=ADDR
                               select project from subaddress of ADDR found
                               in To, Cc, Bcc headers
      status=STATUS            name of the target status
      tracker=TRACKER          name of the target tracker
      category=CATEGORY        name of the target category
      priority=PRIORITY        name of the target priority
      assigned_to=ASSIGNEE     assignee (username or group name)
      fixed_version=VERSION    name of the target version
      private                  create new issues as private
      allow_override=ATTRS     allow email content to set attributes values
                               ATTRS is a comma separated list of attributes
                               or 'all' to allow all attributes to be overridable

See [Issue-attributes](receiving-emails.md#Issue-attributes) for a list of values that can be used for the `allow-override` option.

Examples for the rake command:

      # No project specified. Emails MUST contain the 'Project' keyword:

      rake redmine:email:receive_imap RAILS_ENV="production" \\
        host=imap.foo.bar username=redmine@somenet.foo password=xxx


      # Fixed project and default tracker specified, but emails can override
      # both tracker and priority attributes:

      rake redmine:email:receive_imap RAILS_ENV="production" \\
        host=imap.foo.bar username=redmine@somenet.foo password=xxx ssl=1 \\
        project=foo \\
        tracker=bug \\
        allow_override=tracker,priority

      # Move successful emails to the 'read' mailbox and failed emails to
      # the 'failed' mailbox

      rake redmine:email:receive_imap RAILS_ENV="production" \\
        host=imap.foo.bar username=redmine@somenet.foo password=xxx \\
        move_on_success=read move_on_failure=failed

Ignored emails are marked as ‘Seen’ but are not deleted from the IMAP server—these include unknown user, unknown project and emails from the redmine emission account.

The option *allow_override* is not only for overriding default values given to rake, but for every attribute in a mail. If you want to override the tracker in your mail you have to add *allow_override=tracker* as a parameter.

### Fetching emails from a POP3 server

A rake task (`redmine:email:receive_pop3`) can be used to fetch incoming emails from a POP3 server.

Available POP3 options:

      host=HOST                POP3 server host (default: 127.0.0.1)
      port=PORT                POP3 server port (default: 110)
      username=USERNAME        POP3 account
      password=PASSWORD        POP3 password (use '' if it fails, ex: 'my-password')
      apop=1                   use APOP authentication (default: false)
      delete_unprocessed=1     delete messages that could not be processed
                               successfully from the server (default
                               behaviour is to leave them on the server)

See the [IMAP rake task](receiving-emails.md#Fetching-emails-from-an-IMAP-server) above for issue attributes control options.

### Reading emails from standard input

A rake task (`redmine:email:read`) can be used to read a single raw email from the standard input.

See the [IMAP rake task](receiving-emails.md#Fetching-emails-from-an-IMAP-server) above for issue attributes control options.

Examples:

      # No project specified. Emails MUST contain the 'Project' keyword:
      rake redmine:email:read RAILS_ENV="production" < raw_email

      # Fixed project and default tracker specified, but emails can override
      # both tracker and priority attributes:
      rake redmine:email:read RAILS_ENV="production" \\
                      project=foo \\
                      tracker=bug \\
                      allow_override=tracker,priority < raw_email

The option *allow_override* is not only for overriding default values given to rake, but for every attribute in a mail. If you want to override the tracker in your mail you have to add *allow_override=tracker* as a parameter.

### Enabling unknown users to create issues by email

Redmine has a feature that provides the ability to accept incoming emails from unknown users. In order to use this feature, an extra parameter has to be included:

    unknown_user=ACTION     how to handle emails from an unknown user where ACTION can be one of the following values:
                            ignore: the email is ignored (default)
                            accept: the sender is considered as an anonymous user and the email is accepted
                            create: a user account is created for the sender (username/password are sent back to the user) and the email is accepted

Permissions have to be consistent with the chosen option. E.g. if you choose ‘create’, the ‘Non member’ role must have the ‘Add issues’ permission so that an issue can be created by an unknown user via email. If you choose ‘accept’, the ‘Anonymous’ role must have this permission.

If you receive emails via the rake task, the unknown-user option has to be written as:

     unknown_user=[ignore|accept|create]

You can disable permission checking using the ‘no_permission_check’ option:

    no_permission_check=1   disable permission checking when receiving the email

This, together with the ‘unknown-user’, provides the ability to let anyone submit emails to a private project. For example:

    rdm-mailhandler.rb --unknown-user accept --no-permission-check --project=foo

will let anyone submit emails to a private project ‘foo’.

TODO: Is this true and is this related to the `no_permission_check` option?:\
\> Since Redmine 0.9 the project doesn’t have to be public, but authentication required in the Administration-\> Settings-\>Authentication tab has to be unchecked.

If you do not want an “new account notification email” sent to every newly created user by rdm-mailhandler you must add the option “—no-account-notice”. Is implemneted with version#60 in issue [#11498](https://www.redmine.org/issues/11498). Now an example:

    rdm-mailhandler.rb --unknown-user accept --no-permission-check --project=foo --no-account-notice

### Schedule email receiving with Rufus Scheduler

Instead of using a cron to trigger the Rake task to retrieve incoming email, you can use Rufus Scheduler which will run the Rake task in the same process as Redmine.\
This is using less resources and faster than calling the Rake task from a cron (or from the Task Scheduler on Windows).

To do that, install rufus-scheduler gem:

    gem install rufus-scheduler

Create a what_you_want.rb file in /config/initializers/ and put the following content in your file. (Here for a POP3 account. Change it with your own parameters and own task.)

    require 'rubygems'
    require 'rake'
    require 'rufus-scheduler'

    load File.join(Rails.root, 'Rakefile')

    ENV['host']='pop.toto.com'
    ENV['port']='110'
    ENV['ssl']='SSL'
    ENV['username']='redmine@toto.com'
    ENV['password']='azerty123456'

    scheduler = Rufus::Scheduler.new
    # Check emails every 10 mins
    scheduler.interval '10m' do
      task = Rake.application['redmine:email:receive_pop3']
      task.reenable
      task.invoke
    end

Restart your Redmine instance and your incoming emails will be retrieved on schedule.

You can check [Rufus-Scheduler](https://github.com/jmettraux/rufus-scheduler) for scheduling syntax.

## How it works

When receiving an email, Redmine uses the From address of the email to find the corresponding user. Emails received from unknown or locked users are ignored.

If the email subject contains something like “Re: **\[xxxxxxx #123\]**” or “\[#123\]”, the email is processed as a reply and a note is added to issue #123. Otherwise, a new issue is created.

Note that, in order to create an issue, all required custom fields must be provided. Without them, issue creation will fail. As an alternative you can ensure that every custom field has a default value which is then used during issue creation.

### Target project

The target project can be specified using the `project` option when receiving emails. This should be the identifier of the project and **not** the name. You can easily find the identifier in the URL.

If you don’t use this option, users have to specify in the email body which project the issue should be added to. This can be done by inserting a line in the email body like this: `"Project: foo"`.

Example (email body):

    This is a new issue that will be added to project foo.
    Here we have the issue description
    [...]

    Project: foo

You can set a default project using the `project` option and let users override this default project by using the `allow-override` option when receiving emails.\
Example:

      # Create issues on project foo by default
      rake redmine:email:receive_imap [...] project=foo allow_override=project

Of course, user permissions are checked and this email would be ignored if the user who sent this email is not allowed to add issues to project foo.\
Make sure that the target project doesn’t use **required** custom fields with no default value for its issues, otherwise the creation of the issue will fail.

### Target Project from Email Sub-Address

This feature was introduced in ver 3.2.0 (SVN rev r14687). It may be preferable to have one mailbox for all incoming emails to a Redmine instance, instead of one per project. When receiving emails at redmine@somenet.foo, an email sent to redmine+foo@somenet.foo will cause the issue to be added to project with identifier foo.

To enable this feature add the `project_from_subaddress=redmine`somenet.foo@ to the command e.g.

        rake redmine:email:receive_imap [...] project_from_subaddress=redmine@somenet.foo

If a project is included in the command-line then it becomes the default project that will be used for emails sent to `redmine`somenet.foo@. So with the command:

        rake redmine:email:receive_imap [...] project=bar project_from_subaddress=redmine@somenet.foo

emails to `redmine`somenet.foo@ or `redmine+bar`somenet.foo@ will raise issues in project bar; emails to `redmine+foo`somenet.foo@ will go into project foo.

Some email providers include support for sub-addresses, as per RFCs 3598, 5233. Where this is not supported, forwarding mail addresses to the ‘central’ address, may work (it does in my case), ie set up an email address forwarding all mails to `redmine`somenet.foo@ from `redmine+foo`somenet.foo`, `redmine+bar@somenet.foo@ etc. This is easy to administer and does not require fetching emails from multiple accounts, each with its own account credentials.

### Issue attributes

Based on the options you use when receiving emails (see `allow-override` option), users may be able to override some attributes when submitting an issue.

Note: prior to Redmine version:”3.2.0” (#20543) some attributes were *always* overridable, but this was not documented. This behavior has been changed and all attributes have to be explicitly listed with the `allow_override` option to be overridable. For those who want all attributes to be overridable, `allow_override=all` can now be used (#20543).

Once `allow_override` has been configured, you can override those attributes by using the appropriate keywords in the email body.

Example keyword list:

- `Project`
- `Tracker`
- `Status`
- `Category`
- `Priority`
- `Assigned to`
- `Start date`
- `Due date`
- `Target version`
- `Estimated hours`
- `Done ratio`
- `<Custom field name>`

The values available are the ones of the context. E.g. `Status` available (for this Tracker and this Project) are labels in the localized language, exactly as displayed in the user interface or system default language (even with spaces, without quoting).

Example (email body):

    This is a new issue that overrides a few attributes
    [...]

    Project: foo
    Tracker: Bug
    Priority: Urgent
    Status: Resolved

The format for keywords differs from the allowed attribute values for the `allow_override` option:

- `project`
- `tracker`
- `status`
- `category`
- `priority`
- `assigned_to`
- `start_date`
- `due_date`
- `fixed_version` (aka. Target version)
- `estimated_hours`
- `done_ratio`
- `<custom_field_name>`

Multiple attribute values can be specified in order to allow only certain keywords to be used.

Example:

      # Allow overriding project, tracker, status & priority
      rake redmine:email:receive_imap [...] allow_override=project,tracker,status,priority

### Watchers

If the user who sends the email has the ‘Add issue watchers’ permission, users that are in To or Cc field of the email are automatically added as watchers of the created issue.

Watchers are added only when the issue is created. To or Cc fields are ignored on replies. See [#7017](https://www.redmine.org/issues/7017) and [#8009](https://www.redmine.org/issues/8009).

### Email format and attachments

Redmine tries to use the plain text part of the email to fill the description of the issue.\
If a HTML-only email is received, HTML tags are removed from its body.

Email attachments are automatically attached to the issue, unless their size exceeds the [maximum attachment size](settings.md#Attachment-max-size) defined in the application settings.

### Truncate emails

The Administrator’s settings may be used to automatically truncate emails, for example to eliminate quoted messages in forum replies. To do this, set the outgoing email header to something like `--Reply above this line--` in the Email notifications settings. Then in the Incoming emails settings, enter the same line into the box “Truncate emails after one of these lines.” (It is also possible to allow regex to be truncated)

## See also

- [Mailhandler Frontend for SubAddressing](https://www.redmine.org/projects/redmine/wiki/MailhandlerSubAddress): How to implement sub-addressing in Redmine \<3.2
