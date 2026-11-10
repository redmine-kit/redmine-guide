---
source: RedmineInstall
translated_from_version: 356
---

# インストール

このページは Redmine 6.0 以降のインストール手順です。それより前のバージョンの手順も読めます: [4.0 - 5.1](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/352)、[3.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/308)、[1.4.x - 2.6.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall/263)、[1.3.x](https://www.redmine.org/projects/redmine/wiki/RedmineInstall?version=146)

## 動作環境

### OS

Ruby が動くプラットフォームであれば、Redmine はほとんどの Unix、Linux、[macOS](https://www.redmine.org/projects/redmine/wiki/RedmineInstallOSX)、[Windows](install.md#Notes-on-Windows-installation) で動きます。環境別のインストール手順は[こちら](https://www.redmine.org/projects/redmine/wiki/HowTos)を参照してください。

### Ruby インタープリタと対応データベース

Redmine の各バージョンに必要な Ruby のバージョンと、対応するデータベースは次のとおりです。

<table>
<thead>
<tr>
<th rowspan="2" style="vertical-align: middle;">Redmine のバージョン</th>
<th rowspan="2" style="vertical-align: middle;">対応する Ruby のバージョン<sup>1</sup></th>
<th rowspan="2" style="vertical-align: middle;">使用する Rails のバージョン</th>
<th colspan="4" style="text-align: center;">推奨するデータベース</th>
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
<td>Ruby 3.2, 3.3, 3.4, 4.0<sup>2</sup></td>
<td>Rails 8.1</td>
<td>14</td>
<td>8.0 - 8.4<sup>3</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>7.0</td>
<td>Ruby 3.2, 3.3, 3.4, 4.0<sup>2</sup></td>
<td>Rails 8.1</td>
<td>14</td>
<td>8.0 - 8.4<sup>3</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>6.1</td>
<td>Ruby 3.2, 3.3, 3.4</td>
<td>Rails 7.2</td>
<td>14</td>
<td>8.0 - 8.4<sup>3</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
<tr>
<td>6.0</td>
<td>Ruby 3.1, 3.2, 3.3</td>
<td>Rails 7.2</td>
<td>14</td>
<td>8.0 - 8.1<sup>3</sup></td>
<td>&gt;2012</td>
<td>3</td>
</tr>
</tbody>
</table>

<sup>1</sup> サポートしている Ruby のバージョンのうち、古いものはサポートが終了している場合があります。各バージョンの現在のメンテナンスの状況は https://www.ruby-lang.org/en/downloads/branches/ を参照してください。

<sup>2</sup> Ruby 4.0.0 から 4.0.3 では、Ruby の実行環境そのものの不具合により、Wiki の表示が大幅に遅くなります(#43737。Ruby 側では bugs.ruby-lang.org の \#21856 で追跡されています)。Ruby 4.0.4 で修正されたため、Redmine 7.0 は Ruby 4.0.4 以降で動かすことを推奨します。

<sup>3</sup> **MySQL** を正しく動かすには、`transaction_isolation` を `READ COMMITTED` に変える必要があります。[MySQL_configuration](mysql-configuration.md) を参照してください。

重要な注意:

- **Redmine は JRuby に対応していません**。
- Microsoft SQL Server は [2012 以降](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/blob/v4.2.3/README.md#activerecord-sql-server-adapter-for-sql-server-2012-and-higher)
- SQLite 3(複数のユーザーが使う本番環境には向きません)

### 追加のコンポーネント

- SCM のコマンド(`svn` など)。リポジトリの閲覧に使います(PATH から実行できる必要があります)。SCM の対応状況と要件は [RedmineRepositories](../admin/repositories.md) を参照してください。
- [ImageMagick](http://www.imagemagick.org/)。ガントチャートの PNG 画像へのエクスポートと、サムネイルの生成に使います。
- [Ghostscript](https://www.ghostscript.com/)。PDF の添付ファイルのサムネイルの生成に使います。
- [Pandoc](https://pandoc.org/)。Redmine 7.0 以降で、Microsoft Office の文書(.docx、.xlsx、.pptx)と LibreOffice Writer の文書(.odt)のプレビューに使います。バージョン 3.8.3 以降を推奨します。それより前の Pandoc は .docx と .odt だけに対応しています。
- [Sidekiq](https://github.com/sidekiq/sidekiq)。本番環境に推奨するキューのバックエンドです。

## Redmine のバージョン

ほとんどの利用者には、正式なポイントリリースのインストールを推奨します。Redmine は現在 6 か月ごとに新しいバージョンをリリースしており、リリースは十分に実用的で安定しています。Ruby on Rails に精通していて変更を追い続けられる場合を除き、trunk からのインストールは推奨**しません**。trunk は実際にときどき壊れます。

## インストールの手順

### 手順 1 - Redmine のアプリケーション

リリースされたパッケージをダウンロードし、システムの適切な場所に展開します。\
代わりに、バージョン管理システムから直接チェックアウトすることもできます。

Redmine のダウンロード方法は[ダウンロードのページ](download.md)を参照してください。

### 手順 2 - 空のデータベースとユーザーの作成

以下では、Redmine のデータベースのユーザー名を `redmine` としますが、別の名前でもかまいません。

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

この手順は不要です。データベースのファイルは[手順 7](install.md#Step-7-Database-schema-objects-creation) で作成されます。

#### SQL Server

データベース、ログイン、ユーザーは、SQL Server Management Studio から数回のクリックで作成できます。

`SQLCMD` のコマンドラインで作成する場合の基本的な例を示します。

<details>
<summary>SQL を表示</summary>

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

### 手順 3 - データベースの接続の設定

`config/database.yml.example` を `config/database.yml` にコピーし、「production」環境のデータベースの設定を書きます。MySQL の場合は [MySQL_configuration](mysql-configuration.md) も読んでください。

MySQL のデータベースの例(デフォルトのポート):

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

サーバーが標準のポート(3306)以外で動いている場合は、次のように設定します。

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

PostgreSQL のデータベースの例(デフォルトのポート):

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

SQLite のデータベースの例:

```yml
production:
  adapter: sqlite3
  database: db/redmine.sqlite3
```

SQL Server のデータベースの例(デフォルトのホストは `localhost`、デフォルトのポートは `1433`):

```yml
production:
  adapter: sqlserver
  database: redmine
  username: redmine # should match the database user name
  password: "redminepassword" # should match the login password
```

### 手順 4 - 依存関係のインストール

Redmine は gem の依存関係を [Bundler](http://gembundler.com/) で管理しています。Redmine に必要な gem は、次のコマンドですべてインストールできます。

```text
bundle config set --local without 'development test'
bundle install
```

#### 任意の依存関係

##### データベースのアダプター

Redmine は `config/database.yml` を読み、データベースの設定に必要なアダプターの gem を自動でインストールします(たとえば `mysql2` アダプターの接続だけを設定した場合は、`mysql2` の gem だけがインストールされます)。

`config/database.yml` でアダプターを追加・削除したら、`bundle install` をもう一度実行してください。

##### キューのアダプター

Redmine はデフォルトのキューのアダプターとして `ActiveJob::QueueAdapters::AsyncAdapter` を使いますが、これは本番環境には[推奨されていません](https://api.rubyonrails.org/classes/ActiveJob/QueueAdapters/AsyncAdapter.html)。推奨するアダプターは、永続化に Redis を使う [Sidekiq](https://github.com/sidekiq/sidekiq) です。設定の手順: [SidekiqConfiguration](https://www.redmine.org/projects/redmine/wiki/SidekiqConfiguration)

#### 追加の依存関係(`Gemfile.local`)

Redmine 本体が必要としない gem(Puma、fcgi など)を読み込む場合は、Redmine のディレクトリの直下に `Gemfile.local` というファイルを作成します。このファイルは `bundle install` の実行時に自動で読み込まれます。

例:

```text
# Gemfile.local
gem 'puma'
```

### 手順 5 - セッションストアの秘密鍵の生成

この手順では、セッションのデータを保存する Cookie を Rails がエンコードするためのランダムな鍵を生成し、Cookie の改ざんを防ぎます。\
新しい秘密鍵を生成すると、再起動の後、既存のセッションはすべて無効になります。

```text
bundle exec rake generate_secret_token
```

代わりに、この秘密鍵を config/secrets.yml に保存することもできます:\
http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml

### 手順 6 - アセットのコンパイル(任意)

この手順は任意です。スタイルシート、JavaScript、画像などのアセットを、Web サーバーから配信するために `public/assets` ディレクトリにコンパイルします。

デフォルトでは、Redmine は本番モードでアプリケーションの起動時にアセットを自動で再コンパイルします。この動作は、設定ファイルの `config.assets.redmine_detect_update` で切り替えられます。

自動のコンパイルを無効にしている場合や、生成されたアセット(プラグインやカスタムテーマのアセットを含む)に問題がある場合は、アセットを手動で更新できます。

使用するコマンド: `bin/rails assets:precompile RAILS_ENV="production"`

サブ URI にデプロイする場合は、相対 URL のルートを次のように指定します: `bin/rails assets:precompile RAILS_ENV="production" RAILS_RELATIVE_URL_ROOT=/sub-uri`

ブラウザでアセットが見つからない問題が起きる場合は、public/assets ディレクトリを削除してから、プリコンパイルをもう一度実行してください: `bin/rails assets:clobber RAILS_ENV="production"`

### 手順 7 - データベースのスキーマの作成

アプリケーションのルートディレクトリで次のコマンドを実行し、データベースの構造を作成します。

```text
RAILS_ENV=production bundle exec rake db:migrate
```

**Windows の場合:**

```text
set RAILS_ENV=production
bundle exec rake db:migrate
```

すべてのマイグレーションを順に実行してテーブルを作成し、`admin` という名前のアプリケーションの管理者アカウントを作成します。

### 手順 8 - データベースのデフォルトデータ

次のコマンドを実行し、デフォルトの設定データをデータベースに登録します。

RAILS_ENV=production bundle exec rake redmine:load_default_data

読み込むデータの言語を Redmine が尋ねます。コマンドの実行前に環境変数 `REDMINE_LANG` を設定しておくと、タスクはその値を使い、言語を尋ねません。

例:

Unix 系:

RAILS_ENV=production REDMINE_LANG=fr bundle exec rake redmine:load_default_data

Windows:

```text
set RAILS_ENV=production
set REDMINE_LANG=fr
bundle exec rake redmine:load_default_data
```

### 手順 9 - ファイルシステムの権限

注: *Windows ではこの手順は不要です。*

アプリケーションを実行するユーザーアカウントには、次のサブディレクトリへの書き込み権限が必要です。

1.  `files`(添付ファイルの保存先)
2.  `log`(アプリケーションのログファイル `production.log`)
3.  `tmp` と `tmp/pdf`(ない場合は作成します。PDF 文書の生成などに使います)
4.  `public/assets`(すべてのアセット)

たとえば、アプリケーションを redmine というユーザーアカウントで実行する場合は、次のようにします。

```text
mkdir -p tmp tmp/pdf public/assets
sudo chown -R redmine:redmine files log tmp public/assets
sudo chmod -R 755 files log tmp public/assets
```

注: これらのディレクトリにすでにファイルがある場合(バックアップからファイルを戻した場合など)は、ファイルに実行権限が付いていないようにしてください。

```text
sudo find files log tmp public/assets -type f -exec chmod -x {} +
```

### 手順 10 - インストールの確認

Web サーバーの Puma を起動して、インストールを確認します。`development` と `test` のグループを除外すると Puma はインストールされないため、先に手順 4 の例のように `Gemfile.local` に追加してください。

```text
bundle exec rails server -e production
```

### 手順 11 - アプリケーションへのログイン

デフォルトの管理者アカウントでログインします。

- ログインID: admin
- パスワード: admin

「管理」メニューの「設定」で、アプリケーションのほとんどの設定を変更できます。

## 設定

Redmine の設定は `config/configuration.yml` というファイルに書きます。

アプリケーションのデフォルトの設定を変える場合は、`config/configuration.yml.example` を `config/configuration.yml` にコピーして編集します。ファイルには詳しいコメントがあるので、目を通してください。

これらの設定は Rails の環境(`production`/`development`/`test`)別に書けます。

<u>重要</u>: 変更した後は、必ずアプリケーションを再起動してください。

### メール / SMTP サーバーの設定

メールの設定は[専用のページ](email-configuration.md)で説明しています。

### SCM の設定

この設定では、次のことができます。

- `PATH` にある SCM のコマンドが標準の名前でない場合に、デフォルトのコマンド名を上書きする(Windows の .bat/.cmd の名前は使えません)
- コマンドのフルパスを指定する

例(Subversion の場合):

コマンド名の上書き:

scm_subversion_command: “svn_replacement.exe”

絶対パス:

scm_subversion_command: “C:\Program Files\Subversion\bin\svn.exe”

### 添付ファイルの保存先の設定

`attachments_storage_path` を設定すると、Redmine の添付ファイルを、デフォルトの `files` ディレクトリとは別の場所に保存できます。

例:

attachments_storage_path: /var/redmine/files

attachments_storage_path: D:/redmine/files

## ログの設定

Redmine のデフォルトのログレベルは :info で、`log` サブディレクトリに書き込みます。サイトの使われ方によってはデータが多くなるため、ログファイルが際限なく大きくならないように、`logrotate` などのシステムのユーティリティか、`config/additional_environment.rb` でローテーションすることを検討してください。

後者の場合は、`config/additional_environment.rb.example` を `config/additional_environment.rb` にコピーし、次の行を追加します。新しいロガーのデフォルトのログレベルは高いため、`info` を明示的に指定する必要があります。

```ruby
#Logger.new(PATH,NUM_FILES_TO_ROTATE,FILE_SIZE)
config.logger = Logger.new('/path/to/logfile.log', 2, 1000000)
config.logger.level = Logger::INFO
```

## バックアップ

Redmine のバックアップには、次のものを含めます。

- データ(Redmine のデータベースに保存されています)
- 添付ファイル(Redmine のインストール先の `files` ディレクトリに保存されています)

詳しくは [Redmine のバックアップと復元](https://www.redmine.org/projects/redmine/wiki/RedmineBackupAndRestore)を参照してください。

## Linux/Unix へのインストールの注意

インストール中に原因のわからない権限の問題が起きる場合は、セキュリティを強化するツールを無効にしてください。こうした問題はほとんどエラーを出さず、拡張 ACL、SELinux、AppArmor などのツールが原因になることがあります。これらのツールは主にセキュリティポリシーの厳しい大企業で使われており、Linux/Unix のディストリビューションのデフォルトの設定であれば問題にはならないはずです。

## Windows へのインストールの注意

Ruby MRI のビルド済みのインストーラーが http://rubyinstaller.org で入手できます。\
インストールした後、スタートメニューから *Start Command Prompt with Ruby* を選びます。

<u>環境変数 `RAILS_ENV` の指定:</u>

このガイドのコマンドを実行するときは、環境変数 `RAILS_ENV` を別のコマンドで設定する必要があります。

つまり、次のような形のコマンドは、

```text
RAILS_ENV=production <any commmand>
```

```text
<any commmand> RAILS_ENV=production
```

続けて実行する 2 つのコマンドに書き換えます。

```text
set RAILS_ENV=production
<any commmand>
```

<u>MySQL の gem のインストールの問題:</u>

次のコマンドで mysql2 の gem を手動でインストールする必要がある場合があります。

```text
gem install mysql2
```

また、*libmysql.dll* を ruby/bin ディレクトリにコピーする必要がある場合もあります。\
どの libmysql.dll でもよいわけではありません。次のものは動くようです: http://instantrails.rubyforge.org/svn/trunk/InstantRails-win/InstantRails/mysql/bin/libmySQL.dll

**Windows 7 以降での重要な注意**\
Windows 7 以降では、hosts ファイルの `localhost` がコメントアウトされており<sup>5</sup>、IPv6 がデフォルトです<sup>6</sup>。mysql2 の gem は IPv6 のアドレスに対応していないため<sup>7</sup>、接続できず、「`Can't connect to MySQL server on 'localhost' (10061)`」というエラーになります。\
`localhost` に ping を実行すると確認できます。ping の宛先が「::1:」であれば、IPv6 が使われています。

<u>回避策:</u>\
database.yml の `localhost` を `127.0.0.1` に置き換えます。

<sup>5</sup> http://serverfault.com/questions/4689/windows-7-localhost-name-resolution-is-handled-within-dns-itself-why

<sup>6</sup> http://www.victor-ratajczyk.com/post/2012/02/25/mysql-fails-to-resolve-localhost-disable-ipv6-on-windows.aspx

<sup>7</sup> https://github.com/brianmario/mysql2/issues/279

## 手動のインストールの代わりに

手動でインストールする代わりに、ダウンロードのページにある[サードパーティの Redmine のバンドル](download.md#Third-party-Redmine-bundles)を使うこともできます。
