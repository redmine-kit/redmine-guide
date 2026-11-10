---
source: RedmineRake
translated_from_version: 13
---

# Rake タスク

<div style="color:red;">

WIP

</div>

Redmine には、保守の作業に使う [Rake](http://rake.rubyforge.org) タスクがあります。

Ruby on Rails のフレームワークが定義しているタスクについては、[専用のページ](http://guides.rubyonrails.org/command_line.html#bin-rails)を参照してください。

タスクの一覧は、いつでも `rake -T` コマンドで表示できます。

**タスクを実行するときは**、`RAILS_ENV` 変数を production に設定するのを忘れないでください。

例 (\*nix の場合):

rake redmine:permissions RAILS_ENV=production

Windows の場合:

set RAILS_ENV=production\
rake redmine:permissions

## バッチ処理のタスク

### `rake redmine:attachments:prune`

*バージョン [2.3.0](https://www.redmine.org/versions/60) から使えます。*

ユーザーがチケットや Wiki ページなどにファイルを添付すると、ファイルはすぐにアップロードされ、フォームを送信した後に添付されます。

このタスクは、アップロードされたまま添付されなかった (フォームが送信されなかった) ファイルを、1 日たった後に削除します。

### `rake redmine:email:read`

標準入力からメールを 1 通読み込みます。

### `rake redmine:email:receive_imap`

IMAP サーバーからメールを読み込みます。

### `rake redmine:email:receive_pop3`

POP3 サーバーからメールを読み込みます。

### `rake redmine:fetch_changesets`

リポジトリからコミットを取得します。

### `rake redmine:send_reminders`

期日が近いチケットのリマインダーを送信します。\
参照: [リマインダーメールの送信](reminder-emails.md)

### `rake redmine:tokens:prune`

期限切れのトークンを削除します。

### `rake redmine:watchers:prune`

閲覧できなくなったものから、ウォッチャーを削除します。\
バージョン [2.3.0](https://www.redmine.org/versions/60) から使えます。

## その他の保守のタスク

### `rake generate_secret_token`

アプリケーションの秘密トークンを生成します。

### `rake db:encrypt` と `rake db:decrypt`

データベースに保存している SCM と LDAP のパスワードを、暗号化または復号します。

### `rake redmine:attachments:move_to_subdirectories`

ファイルのディレクトリの直下に保存されている添付ファイルを移動します (つまり\
バージョン [2.3.0](https://www.redmine.org/versions/60) から使えます。

### `rake redmine:email:test[login]`

指定したログイン ID のユーザーに、テストメールを送信します。

### `rake redmine:permissions`

すべての権限と、それぞれに登録されているアクションを一覧で表示します。

### `rake redmine:plugins`

プラグインのマイグレーションを実行します。

### `rake redmine:plugins:assets`

Redmine 7.0.3 には、このタスクはありません。

### `rake redmine:plugins:migrate`

インストールしたプラグインのマイグレーションを実行します。

## ほかの BTS からの移行

### `rake redmine:migrate_from_mantis`

Mantis からの移行スクリプトです。このタスクはメンテナンスされておらず、Redmine 7.0.3 では使えません (Redmine 7.0.0 で非推奨になりました)。

### `rake redmine:migrate_from_trac`

Trac からの移行スクリプトです。このタスクはメンテナンスされておらず、Redmine 7.0.3 では使えません (Redmine 7.0.0 で非推奨になりました)。
