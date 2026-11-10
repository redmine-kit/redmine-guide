---
source: EmailConfiguration
source_url: https://www.redmine.org/projects/redmine/wiki/EmailConfiguration
source_version: 58
source_updated_on: '2024-10-21T11:54:17Z'
updated_for: 7.0.3
---

# Email Configuration

## Configuration Directives

This page is a work in progress, the following configuration directives are only a partial list. Please consult [Action Mailer Configuration](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration)\
for detailed information.

### authentication

The type of authentication method expected by your service provider.

Valid settings:

- `nil` (or omit the key) for no authentication
- `:plain`
- `:login`
- `:cram_md5`

(note: if you set this to `nil` or omit it, you must not include the `user_name` and `password` settings)

### delivery_method

The mail transport method to be used.

Valid settings (=\< Redmine v3.x):

- `:smtp`
- :`sendmail`
- `:async_smtp`
- `:async_sendmail`

Valid settings (\>= Redmine v4.x; cf. [#30068](https://www.redmine.org/issues/30068)):

- `:smtp`
- :`sendmail`

#### Asynchronous delivery_methods

The `:async_smtp` and `:async_sendmail` use asynchronous sends, which means Redmine does not wait for the email to be sent to display the next page. See [Asynchronous Email Delivery](http://redmineblog.com/articles/asynchronous-email-delivery/) for more details. Some SMTP servers have delay period before processing takes place as an anti-spam feature, during which time synchronous method will block Redmine ([10 seconds](https://community.bitnami.com/t/updating-an-issue-in-redmine-takes-10-seconds/4421) could be a default value, see also [#11376](https://www.redmine.org/issues/11376) for more information).

With this delivery method, smtp configuration is specified using `async_smtp_settings` keyword instead of `smtp_settings` keyword:

```yml
development:
  delivery_method: :async_smtp
  async_smtp_settings:  # Don't use "smtp_settings"
    address: ...
    port: ...
    ...
```

<blockquote>

**Please note:** Since Redmine 4.0 asynchronous email sending is removed in favour of Rails ActiveJob module which sends emails asynchronously.See https://www.redmine.org/projects/redmine/repository/entry/tags/4.0.0/lib/redmine/configuration.rb#L53 for more details.

</blockquote>

## Example configuration.yml Configurations

### Simple Login Authentication (default settings)

```yml
# Outgoing email settings

production:
  delivery_method: :smtp
  smtp_settings:
    address: smtp.example.net
    port: 25
    domain: example.net
    authentication: :login
    user_name: redmine@example.net
    password: redmine

development:
  delivery_method: :smtp
  smtp_settings:
    address: 127.0.0.1
    port: 25
    domain: example.net
    authentication: :login
    user_name: redmine@example.net
    password: redmine
```

### GMail, Google Apps

If you want to use GMail/Google Apps and other TLS-requiring SMTP servers, you’ll have to add some TLS-related settings:

```yml
production:
  delivery_method: :smtp
  smtp_settings:
    enable_starttls_auto: true
    address: "smtp.gmail.com"
    port: 587
    domain: "smtp.gmail.com"
    authentication: :plain
    user_name: "your_email@gmail.com"
    password: "your_password"
```

When sending from G Suite (formerly Google Apps), it’s good to use **SMTP relay** which has much larger sending limits.\
More information and detailed guide how to enable SMTP relay is here: https://support.google.com/a/answer/2956491\
When configuring SMTP relay service use something like this:

- Name: Redmine
- 1\. Allowed senders:
  - Only registered Apps users in my domains - in case You have created dedicated G Suite user for Redmine
- 2\. Authentication
  - \[x\] Only accept mail from the specified IP addresses - IP address of your Redmine server
  - \[x\] Require SMTP Authentication
- 3\. Encryption
  - \[x\] Require TLS encryption

And config can be really simple:

```yml
production:
  delivery_method: :smtp
  smtp_settings:
    address: smtp-relay.gmail.com
    port: 587
    domain: smtp-relay.gmail.com
    authentication: :plain
    user_name: your_email@gmail.com
    password: your_password
```

### Office 365, Exchange Online

Here is an example for Office 365 users (Exchange online). The sender must have an account, or if you want to send from a shared mailbox, the account below must have authorization to “Send As” the sender which is defined in Redmine email notifications settings.

```yml
production:
  delivery_method: :smtp
  smtp_settings:
    enable_starttls_auto: true
    address: "smtp.office365.com"
    port: 587
    domain: "your_domain.com"
    authentication: :login
    user_name: "email@your_domain.com"
    password: "password"
```

Note: the O365 SMTP server limits the number of parallel connections to three. Therefore, the number of sender thread needs to be limited as well. See [#31957](https://www.redmine.org/issues/31957) for details.

### No Authentication

Example for an SMTP service provider with no authentication.

```yml
production:
  delivery_method: :smtp
  smtp_settings:
    address: smtp.knology.net
    port: 25
    domain: cybersprocket.com
```

### Using sendmail command

Example for a unix system that uses the `/usr/sbin/sendmail` command.

```yml
production:
  delivery_method: :sendmail
```

## Troubleshooting

### Error: “hostname was not match with the server certificate”

If you get this error, there’s probably a problem verifying the SSL certificate of your smtp relay. As a temporary fix, you can set this option in the appropriate “smtp_settings” section:

```yml
enable_starttls_auto: false
```

If you have to enable starttls and just want to bypass the certificate verification, you can add following option in the appropriate “smtp_settings” section:

```yml
openssl_verify_mode: "NONE"
```

### Error: “Mail failure - no recipient addresses”

When this error happens, the notification is not delivered to the destination address. Instead, you will probably receive a rejection message on your sender address, where you can see the header of the message sent, containing “From:” fields but not containing any “To:” fields.

This error is common on **Debian** boxes, due to the way *exim4* is configured by default, which is `"-i -t"`. This configuration tells *exim4* that the destination address is inside the header of the message. Instead, we need to configure *exim4* so that the destination address will be retrieved from the command line.

The solution consists on editing your *config/configuration.yml* and making sure you define `arguments` containing the string `"-i"`, as shown below:

```yml
# default configuration options for all environments
default:
  delivery_method: :sendmail
  sendmail_settings:
    arguments: "-i"
```

The example above employs `:sendmail` method, which employs `sendmail_settings`. In case you are using `:smtp` method, try `smtp_settings` instead.

### Error: “Timeout:Error” due to SSL SMTP server connection

add an ssl option to the configuration.yml [#17239](https://www.redmine.org/issues/17239)

```yml
default:
  # Outgoing emails configuration (see examples above)
  email_delivery:
    delivery_method: :smtp
  smtp_settings:
    address: smtp.domain.com
    port: 465
    ssl: true
    enable_starttls_auto: true
    domain: domain.com
    authentication: :login
    user_name: redmine@domain.com
    password: xxxx
```

### Email delivery error: Net::ReadTimeout with \#\<Socket:(closed)\>

Increase the timeout in configuration.yml with `<code>read_timeout: 300</code>`.

## More information

- [Action Mailer Configuration](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration)
