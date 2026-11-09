---
source: EmailConfiguration
translated_from_version: 58
---

# メールの設定

## 設定項目

このページは作成中で、以下の設定項目は一部にすぎません。詳しくは [Action Mailer Configuration](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration)\
を参照してください。

### authentication

サービスプロバイダーが求める認証方式の種類です。

設定できる値:

- `nil`(またはキーを省略): 認証なし
- `:plain`
- `:login`
- `:cram_md5`

(注: `nil` を設定するか省略した場合は、`user_name` と `password` の設定を書いてはいけません)

### delivery_method

メールの送信方法です。

設定できる値(Redmine v3.x 以前):

- `:smtp`
- `:sendmail`
- `:async_smtp`
- `:async_sendmail`

設定できる値(Redmine v4.x 以降。\[#30068](https://www.redmine.org/issues/30068) を参照):

- `:smtp`
- `:sendmail`

#### 非同期の delivery_method

`:async_smtp` と `:async_sendmail` は非同期で送信します。つまり、Redmine はメールの送信を待たずに次のページを表示します。詳しくは [Asynchronous Email Delivery](http://redmineblog.com/articles/asynchronous-email-delivery/) を参照してください。SMTP サーバーの中には、スパム対策として処理を始める前に待ち時間を設けるものがあり、同期の送信方法ではその間 Redmine が止まります(デフォルトの値は [10 秒](https://community.bitnami.com/t/updating-an-issue-in-redmine-takes-10-seconds/4421)のことがあります。詳しくは \[#11376](https://www.redmine.org/issues/11376) も参照してください)。

この送信方法では、SMTP の設定を `smtp_settings` ではなく `async_smtp_settings` に書きます。

```yaml
development:
  delivery_method: :async_smtp
  async_smtp_settings:  # Don't use "smtp_settings"
    address: ...
    port: ...
    ...
```

> **注意:** Redmine 4.0 で非同期のメール送信は削除され、メールを非同期で送信する Rails の ActiveJob モジュールに置き換えられました。詳しくは https://www.redmine.org/projects/redmine/repository/entry/tags/4.0.0/lib/redmine/configuration.rb#L53 を参照してください。

## configuration.yml の設定例

### シンプルなログイン認証(デフォルトの設定)

```yaml
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

GMail/Google Apps など、TLS が必要な SMTP サーバーを使う場合は、TLS の設定を追加する必要があります。

```yaml
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

G Suite(旧 Google Apps)から送信する場合は、送信の上限がはるかに大きい **SMTP リレー** を使うとよいでしょう。\
SMTP リレーの詳しい情報と有効にする手順は https://support.google.com/a/answer/2956491 にあります。\
SMTP リレーサービスは、たとえば次のように設定します。

- 名前: Redmine
- 1\. 許可する送信者:
  - 自分のドメインの登録済みの Apps ユーザーのみ(Redmine 専用の G Suite ユーザーを作成した場合)
- 2\. 認証
  - \[x\] 指定した IP アドレスからのメールのみ受け付ける(Redmine のサーバーの IP アドレス)
  - \[x\] SMTP 認証を必須とする
- 3\. 暗号化
  - \[x\] TLS 暗号化を必須とする

設定はとてもシンプルになります。

```yaml
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

Office 365(Exchange Online)の利用者向けの例です。送信者にはアカウントが必要です。共有メールボックスから送信する場合は、下のアカウントに、Redmine の「メール通知」の設定で指定した送信者として「送信者として送信」する権限が必要です。

```yaml
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

注: O365 の SMTP サーバーは、同時接続の数を 3 に制限しています。そのため、送信するスレッドの数も制限する必要があります。詳しくは \[#31957](https://www.redmine.org/issues/31957) を参照してください。

### 認証なし

認証のない SMTP サービスプロバイダーの例です。

```yaml
production:
  delivery_method: :smtp
  smtp_settings:
    address: smtp.knology.net
    port: 25
    domain: cybersprocket.com
```

### sendmail コマンドを使う

`/usr/sbin/sendmail` コマンドを使う Unix システムの例です。

```yaml
production:
  delivery_method: :sendmail
```

## トラブルシューティング

### エラー:「hostname was not match with the server certificate」

このエラーが出る場合は、SMTP リレーの SSL 証明書の検証に問題がある可能性があります。一時的な対処として、該当する「smtp_settings」のセクションに次のオプションを設定できます。

```yaml
    enable_starttls_auto: false
```

STARTTLS は有効にしたまま、証明書の検証だけを省く場合は、該当する「smtp_settings」のセクションに次のオプションを追加します。

```yaml
    openssl_verify_mode: "NONE"
```

### エラー:「Mail failure - no recipient addresses」

このエラーが起きると、通知は宛先のアドレスに届きません。代わりに、送信元のアドレスに拒否のメッセージが届くことがあります。そこで送信したメッセージのヘッダーを見ると、「From:」はあっても「To:」がありません。

このエラーは **Debian** のマシンでよく起きます。*exim4* のデフォルトの設定が `"-i -t"` であることが原因です。この設定は、宛先のアドレスがメッセージのヘッダーの中にあることを *exim4* に指示します。そうではなく、宛先のアドレスをコマンドラインから受け取るように *exim4* を設定する必要があります。

解決するには、*config/configuration.yml* を編集し、次のように `"-i"` という文字列の `arguments` を指定します。

```yaml
# default configuration options for all environments
default:
  delivery_method: :sendmail
  sendmail_settings:
    arguments: "-i"
```

上の例は `:sendmail` を使っているため、`sendmail_settings` に書いています。`:smtp` や `:async_smtp` を使っている場合は、`smtp_settings` を試してください。

### SSL の SMTP サーバーへの接続による「Timeout:Error」

configuration.yml に ssl のオプションを追加します(\[#17239](https://www.redmine.org/issues/17239))。

```yaml
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

### メールの送信エラー: Net::ReadTimeout with \#\<Socket:(closed)\>

configuration.yml で、次のようにタイムアウトを延ばします。

```yaml
read_timeout: 300
```

## 詳しい情報

- [Action Mailer Configuration](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration)
