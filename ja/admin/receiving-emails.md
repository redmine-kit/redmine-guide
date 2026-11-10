---
source: RedmineReceivingEmails
translated_from_version: 93
---

# 受信メール

Redmine は、メールでチケットの作成やコメントの追加ができるように設定できます。また、フォーラムのメッセージへのメールの返信を認識して取り込むこともできます。

## 設定

Redmine でメールを受信するには、次のいずれかの方法で設定します。

- メールサーバーからメールを転送する
  - 長所: リモートのメールサーバーで使える。メールがすぐに処理される。速い(環境を読み込み直さない)
  - 短所: メール転送エージェント(Postfix、Sendmail など)の設定が必要
- IMAP か POP3 のサーバーからメールを取得する
  - 長所: 設定が簡単。MTA の設定が不要。リモートのメールサーバーで使える
  - 短所: メールがすぐには処理されない(メールを定期的に読み込む cron ジョブの追加が必要)
- 標準入力からメールを読み込む
  - 長所: テストに向いている
  - 短所: 遅い(メールを読み込むたびに環境を読み込み直す)。MTA の設定が必要

### メールサーバーからのメールの転送

単独で動くスクリプトを使って、受信したメールをメールサーバーから転送できます。\
このスクリプトは、生のメールを標準入力から読み込み、HTTP リクエストで Redmine に転送します。\
スクリプトは Redmine のディレクトリの `extra/mail_handler/rdm-mailhandler.rb` にあります。

使うには、メールを受け取る API を有効にする必要があります。\
*「設定」* > *「受信メール」*を開き、「受信メール用のWebサービスを有効にする」にチェックを入れ、秘密のキーを入力するか生成します。

`rdm-mailhandler.rb` をメールサーバーにコピーし、実行できるパーミッションにして(`chmod +x rdm-mailhandler.rb`)、MTA(メール転送エージェント)を設定します。

使い方:

```text
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
```

`--allow-override` のオプションに使える値の一覧は、[チケットの属性](receiving-emails.md#Issue-attributes)を参照してください。

例:

  ```text
    # No project specified. Emails MUST contain the 'Project' keyword:
    rdm-mailhandler.rb --url http://redmine.domain.foo --key secret

    # Fixed project and default tracker specified, but emails can override
    # both tracker and priority attributes:
    rdm-mailhandler.rb --url https://domain.foo/redmine --key secret \\
                       --project foo \\
                       --tracker bug \\
                       --allow-override tracker,priority
  ```

Postfix のローカルのエイリアスの設定例です。

```text
foo: "|/path/to/rdm-mailhandler.rb --url http://redmine.domain --key secret --project foo"
```

この行は、aliases のファイル(通常は `/etc/aliases`)に書きます。場所がわからないときは、`postconf alias_maps` コマンドで確認します。aliases のファイルを更新したら、`newaliases` を実行して、新しい設定を Postfix に通知してください。

ドメインを仮想メールボックスのマップとして設定している(/etc/postfix/virtual_mailbox_maps で ` user@example.com /path/example.com/user` の形式の対応付けをしている)ときは、次のようにします。

- `/etc/virtual` に、` foo@example.org foo` のような対応付けを作成します
- `/etc/postfix/main.cf` を変更して、トランスポートのファイルを指定します: `transport_maps = hash:/etc/postfix/transport`
- トランスポートのファイルに、` foo@example.org local:` のような行を追加します

**説明:** - ドメインに virtual_mailbox_maps を設定すると、デフォルトのトランスポートは virtual になります。そのため、`/etc/postfix/virtual` にローカルのエイリアスを指定しても失敗します(「unknown user」になります)。これを直すには、該当するメールアドレスにローカルのトランスポートを指定して、デフォルトのトランスポートを上書きします。こうすると、ローカルのエイリアスが正しく解決され、スクリプトが実行されます。

### IMAP サーバーからのメールの取得

rake タスク(`redmine:email:receive_imap`)で、IMAP サーバーから受信メールを取得できます。cron ジョブから rake コマンドを実行するときは、rake コマンドに `-f /path/to/redmine/appdir/Rakefile` のスイッチを付けます。付けないと Rakefile が見つかりません。30 分ごとにメールを取得する cron のファイルの行の例です。

```text
*/30 * * * * redmineuser rake -f /path/to/redmine/appdir/Rakefile redmine:email:receive_imap RAILS_ENV="production" host=imap.foo.bar username=redmine@somenet.foo password=xxx
```

設定は動いているのに cron デーモンからメールが届くときは、—silent のスイッチを付けて rake コマンドの出力を抑えられます。コマンドを実行するたびに cron がメールを送ることがなくなります。

```text
*/30 * * * * redmineuser rake -f /path/to/redmine/appdir/Rakefile --silent redmine:email:receive_imap RAILS_ENV="production" host=imap.foo.bar username=redmine@somenet.foo password=xxx
```

cron のファイルでは、コマンドを 1 行で書く必要があります。下のほかの例は、`-f` のオプションと cron の部分を除いた rake コマンドだけを示しています。

Windows のサーバーでは、[pycron](http://www.kalab.com/freeware/pycron/pycron.htm) で取得のタスクをスケジュールできます。

マシンのファイアウォールで、IMAP のポート 143 への外向きの TCP 接続を許可する必要がある場合があります。

使える IMAP のオプション:

  ```text
    host=HOST                IMAP server host (default: 127.0.0.1)
    port=PORT                IMAP server port (default: 143)
    ssl=SSL                  Use SSL/TLS? (default: false)
                             Setting `ssl=force` disables server certificate
                             verification
    starttls=STARTTLS        Use STARTTLS? (default: false)
    username=USERNAME        IMAP account
    password=PASSWORD        IMAP password
    folder=FOLDER            IMAP folder to read (default: INBOX)
    move_on_success=MAILBOX  move emails that were successfully received
                             to MAILBOX instead of deleting them
    move_on_failure=MAILBOX  move emails that were ignored to MAILBOX
  ```

ユーザーと権限のオプション:

  ```text
    unknown_user=ACTION      how to handle emails from an unknown user
                             ACTION can be one of the following values:
                             ignore: email is ignored (default)
                             accept: accept as anonymous user
                             create: create a user account
    no_permission_check=1    disable permission checking when receiving
                             the email
    no_account_notice=1      disable new user account notification
    no_notification=1        disable email notification to new user
    default_group=foo,bar    adds created user to foo and bar groups
  ```

チケットの属性を制御するオプション:

  ```text
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
  ```

`allow-override` のオプションに使える値の一覧は、[チケットの属性](receiving-emails.md#Issue-attributes)を参照してください。

rake コマンドの例:

  ```text
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
  ```

無視したメールは IMAP サーバーで「既読」になりますが、削除はされません。無視するのは、未登録のユーザーや存在しないプロジェクトのメール、Redmine の送信用のアカウントからのメールなどです。

*allow_override* のオプションは、rake に渡したデフォルト値を上書きするためだけでなく、メールのすべての属性に使います。メールでトラッカーを上書きするには、パラメータに *allow_override=tracker* を付ける必要があります。

### POP3 サーバーからのメールの取得

rake タスク(`redmine:email:receive_pop3`)で、POP3 サーバーから受信メールを取得できます。

使える POP3 のオプション:

  ```text
    host=HOST                POP3 server host (default: 127.0.0.1)
    port=PORT                POP3 server port (default: 110)
    username=USERNAME        POP3 account
    password=PASSWORD        POP3 password (use '' if it fails, ex: 'my-password')
    apop=1                   use APOP authentication (default: false)
    ssl=SSL                  Use SSL? (default: false)
                             Setting `ssl=force` disables server certificate
                             verification
    delete_unprocessed=1     delete messages that could not be processed
                             successfully from the server (default
                             behaviour is to leave them on the server)
  ```

チケットの属性を制御するオプションは、上の [IMAP の rake タスク](receiving-emails.md#Fetching-emails-from-an-IMAP-server)を参照してください。

### 標準入力からのメールの読み込み

rake タスク(`redmine:email:read`)で、標準入力から生のメールを 1 通読み込めます。

チケットの属性を制御するオプションは、上の [IMAP の rake タスク](receiving-emails.md#Fetching-emails-from-an-IMAP-server)を参照してください。

例:

  ```text
    # No project specified. Emails MUST contain the 'Project' keyword:
    rake redmine:email:read RAILS_ENV="production" < raw_email

    # Fixed project and default tracker specified, but emails can override
    # both tracker and priority attributes:
    rake redmine:email:read RAILS_ENV="production" \\
                    project=foo \\
                    tracker=bug \\
                    allow_override=tracker,priority < raw_email
  ```

*allow_override* のオプションは、rake に渡したデフォルト値を上書きするためだけでなく、メールのすべての属性に使います。メールでトラッカーを上書きするには、パラメータに *allow_override=tracker* を付ける必要があります。

### 未登録のユーザーがメールでチケットを作成できるようにする

Redmine には、未登録のユーザーからの受信メールを受け付ける機能があります。この機能を使うには、次のパラメータを追加する必要があります。

```text
unknown_user=ACTION     how to handle emails from an unknown user where ACTION can be one of the following values:
                        ignore: the email is ignored (default)
                        accept: the sender is considered as an anonymous user and the email is accepted
                        create: a user account is created for the sender (username/password are sent back to the user) and the email is accepted
```

権限は、選択したオプションに合わせる必要があります。たとえば「create」を選択したときは、未登録のユーザーがメールでチケットを作成できるように、「非メンバー」のロールに「チケットの追加」の権限が必要です。「accept」を選択したときは、「匿名ユーザー」のロールにこの権限が必要です。

rake タスクでメールを受信するときは、未登録のユーザーのオプションを次のように書きます。

 ```text
  unknown_user=[ignore|accept|create]
 ```

「no_permission_check」のオプションで、権限のチェックを無効にできます。

```text
no_permission_check=1   disable permission checking when receiving the email
```

これを「unknown-user」と組み合わせると、だれでも非公開のプロジェクトにメールを送れるようにできます。例:

```text
rdm-mailhandler.rb --unknown-user accept --no-permission-check --project=foo
```

これで、だれでも非公開のプロジェクト「foo」にメールを送れます。

TODO: これは正しいか、また `no_permission_check` のオプションと関係があるか:\
<blockquote>

Redmine 0.9 から、プロジェクトは公開でなくてもよくなりましたが、「管理」 > 「設定」 > 「認証」のタブの「認証が必要」のチェックを外す必要があります。

</blockquote>

rdm-mailhandler で新しく作成したユーザーのそれぞれに「新しいアカウントの通知のメール」を送らないようにするには、オプション「—no-account-notice」を付ける必要があります。[2.3.0](https://www.redmine.org/versions/60) で、チケット [#11498](https://www.redmine.org/issues/11498) として実装されました。例:

```text
rdm-mailhandler.rb --unknown-user accept --no-permission-check --project=foo --no-account-notice
```

### Rufus Scheduler によるメールの受信のスケジュール

受信メールを取得する Rake タスクを cron で起動する代わりに、Rufus Scheduler を使って、Redmine と同じプロセスで Rake タスクを実行できます。\
cron(Windows ではタスク スケジューラ)から Rake タスクを呼び出すより、使うリソースが少なく、速く動きます。

そのためには、rufus-scheduler の gem をインストールします。

```text
gem install rufus-scheduler
```

/config/initializers/ に what_you_want.rb のようなファイルを作成し、次の内容を書きます(この例は POP3 のアカウントの場合です。パラメータとタスクは自分のものに変えてください)。

```text
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
```

Redmine のインスタンスを再起動すると、受信メールがスケジュールどおりに取得されます。

スケジュールの構文は、[Rufus-Scheduler](https://github.com/jmettraux/rufus-scheduler) を参照してください。

## 仕組み

Redmine はメールを受信すると、メールの From のアドレスで該当するユーザーを探します。未登録のユーザーやロック中のユーザーからのメールは無視します。

メールの件名に「Re: **\[xxxxxxx #123\]**」や「\[#123\]」のような文字列があるときは、メールを返信として処理し、チケット #123 にコメントを追加します。それ以外のときは、新しいチケットを作成します。

チケットを作成するには、必須のカスタムフィールドの値がすべてそろっている必要があります。そろっていないと、チケットの作成は失敗します。代わりに、すべてのカスタムフィールドにデフォルト値を設定しておくと、チケットの作成時にその値が使われます。

### 対象のプロジェクト

対象のプロジェクトは、メールを受信するときに `project` のオプションで指定できます。指定するのはプロジェクトの識別子で、名前では**ありません**。識別子は URL で簡単に確認できます。

このオプションを使わないときは、チケットを追加するプロジェクトを、ユーザーがメールの本文で指定する必要があります。メールの本文に `"Project: foo"` のような行を入れます。

例(メールの本文):

```text
This is a new issue that will be added to project foo.
Here we have the issue description
[...]

Project: foo
```

メールを受信するときに、`project` のオプションでデフォルトのプロジェクトを設定し、`allow-override` のオプションで、ユーザーがこのデフォルトのプロジェクトを上書きできるようにすることもできます。\
例:

  ```text
    # Create issues on project foo by default
    rake redmine:email:receive_imap [...] project=foo allow_override=project
  ```

もちろん、ユーザーの権限はチェックされます。メールを送ったユーザーにプロジェクト foo でチケットを追加する権限がないときは、このメールは無視されます。\
対象のプロジェクトのチケットで、デフォルト値のない「**必須**」のカスタムフィールドを使っていないことを確認してください。使っていると、チケットの作成は失敗します。

### メールのサブアドレスによる対象のプロジェクトの指定

この機能は、バージョン 3.2.0(SVN のリビジョン [r14687](https://www.redmine.org/projects/redmine/repository/svn/revisions/14687))で追加されました。プロジェクトごとにメールボックスを用意するより、Redmine のインスタンスへの受信メールすべてに 1 つのメールボックスを使うほうが望ましい場合があります。redmine@somenet.foo でメールを受信しているとき、redmine+foo@somenet.foo に送られたメールは、識別子が foo のプロジェクトにチケットとして追加されます。

この機能を有効にするには、コマンドに `project_from_subaddress=redmine@somenet.foo` を追加します。例:

````text
```text
    rake redmine:email:receive_imap [...] project_from_subaddress=redmine@somenet.foo
```
````

コマンドラインでプロジェクトも指定すると、`redmine@somenet.foo` に送られたメールに使うデフォルトのプロジェクトになります。つまり、次のコマンドでは

````text
```text
    rake redmine:email:receive_imap [...] project=bar project_from_subaddress=redmine@somenet.foo
```
````

`redmine@somenet.foo` か `redmine+bar@somenet.foo` へのメールはプロジェクト bar のチケットになり、`redmine+foo@somenet.foo` へのメールはプロジェクト foo に入ります。

RFC 3598、5233 のとおりにサブアドレスに対応しているメールのプロバイダーもあります。対応していないときは、メールアドレスを「中央」のアドレスに転送すると動くことがあります(筆者の場合は動きました)。つまり、`redmine+foo@somenet.foo`、`redmine+bar@somenet.foo` などから `redmine@somenet.foo` にすべてのメールを転送するメールアドレスを設定します。管理が簡単で、それぞれに資格情報がある複数のアカウントからメールを取得する必要もありません。

### チケットの属性

メールを受信するときに使うオプション(`allow-override` のオプションを参照)によっては、ユーザーがチケットを送るときに一部の属性を上書きできます。

注: Redmine のバージョン 3.2.0 より前(#20543)は、一部の属性が*常に*上書きできましたが、このことは文書化されていませんでした。この動作は変更され、上書きできるようにするには、すべての属性を `allow_override` のオプションで明示的に指定する必要があります。すべての属性を上書きできるようにするには、`allow_override=all` を使えるようになりました(#20543)。

`allow_override` を設定したら、メールの本文で該当するキーワードを使って、それらの属性を上書きできます。

キーワードの一覧の例:

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

使える値は、その状況に応じたものです。たとえば、(そのトラッカーとそのプロジェクトで)使える `Status` の値は、ユーザーの言語のラベルで、画面に表示されるとおりのもの、またはシステムのデフォルトの言語のものです(空白があってもそのまま、引用符で囲まずに書きます)。

例(メールの本文):

```text
This is a new issue that overrides a few attributes
[...]

Project: foo
Tracker: Bug
Priority: Urgent
Status: Resolved
```

キーワードの書き方は、`allow_override` のオプションで指定できる属性の値とは異なります。

- `project`
- `tracker`
- `status`
- `category`
- `priority`
- `assigned_to`
- `start_date`
- `due_date`
- `fixed_version`(対象バージョン)
- `estimated_hours`
- `done_ratio`
- `<custom_field_name>`

特定のキーワードだけを使えるようにするには、複数の属性の値を指定します。

例:

  ```text
    # Allow overriding project, tracker, status & priority
    rake redmine:email:receive_imap [...] allow_override=project,tracker,status,priority
  ```

### ウォッチャー

メールを送ったユーザーに「ウォッチャーの追加」の権限があるときは、メールの To か Cc の欄にあるユーザーが、作成したチケットのウォッチャーに自動で追加されます。

ウォッチャーが追加されるのは、チケットを作成するときだけです。返信では To と Cc の欄は無視されます。[#7017](https://www.redmine.org/issues/7017) と [#8009](https://www.redmine.org/issues/8009) を参照してください。

### メールの形式と添付ファイル

Redmine は、「マルチパート (HTML) メールの優先パート」の設定で選択した部分 (デフォルトは「テキスト」) を使ってチケットの説明を入力し、メールにその部分がないときはもう一方の部分を使います。\
HTML の部分はテキストに変換します。

メールの添付ファイルは、アプリケーションの設定の[「添付ファイルサイズの上限」](settings.md#Attachment-max-size)を超えない限り、自動でチケットに添付されます。

### メールの切り捨て

管理者の設定で、メールを自動で切り捨てることができます。たとえば、フォーラムの返信で引用されたメッセージを取り除けます。そのためには、「メール通知」の設定で、送信するメールのヘッダを `--Reply above this line--` のようにします。次に「受信メール」の設定で、「メール本文から一致する行以降を切り捨てる」の欄に同じ行を入力します。(正規表現で切り捨てるようにすることもできます。)

## 関連項目

- [Mailhandler Frontend for SubAddressing](https://www.redmine.org/projects/redmine/wiki/MailhandlerSubAddress): 3.2 より前の Redmine でサブアドレスを実装する方法
