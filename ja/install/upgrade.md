---
source: RedmineUpgrade
translated_from_version: 84
---

# バージョンアップ

以下の説明は、Redmine 2.x 以降へのバージョンアップを前提にしています。Redmine 1.x へのバージョンアップの説明は、以前のページを[こちら](https://www.redmine.org/projects/redmine/wiki/RedmineUpgrade?version=53)で読めます。

## 手順 1 - 動作環境の確認

Redmine のバージョンアップでは、まず、これからインストールするバージョンの[動作環境](install.md#Requirements)を満たしていることを確認します。

## 手順 2 - バックアップ

データベースとアップロードされたファイルをバックアップすることをお勧めします。ほとんどのバージョンアップは安全ですが、万一に備えてバックアップしておいて損はありません。

Redmine のバックアップの方法は、[Redmine のバックアップと復元](https://www.redmine.org/projects/redmine/wiki/RedmineBackupAndRestore)を読んでください。

## 手順 3 - バージョンアップの実行

いよいよバージョンアップを実行します。手順は Redmine をどのように入手したかによって異なります。次の方法の**どちらか一方**だけを実行してください。

### 方法 1 - 安定バージョンのリリースをダウンロードする

1\. リリースを tar.gz か zip の形式で[ダウンロード](download.md)し、新しいプログラムのアーカイブを新しいディレクトリに展開します。

展開・コピーしたファイルとディレクトリの所有者とグループを正しく設定し、アプリケーションサーバーを実行するユーザー/グループがファイルにアクセスできるようにしてください。\
また、`files`、`log`、`tmp` ディレクトリに書き込み権限を付けるのを忘れないでください。

2\. データベースの設定ファイル `config/database.yml` を新しい `config` ディレクトリにコピーします。Redmine 1.4 以降を mysql と ruby1.9 で動かしている場合は、データベースのアダプターを `mysql2` に変えます。

3a. 基本の設定ファイル `config/configuration.yml` を新しい `config` ディレクトリにコピーします。

3b. または、**1.2.0 より前のバージョンからバージョンアップする場合**は、`config/email.yml` のメールの設定を新しい `config/configuration.yml` にコピーします。`config/configuration.yml` は、付属の `configuration.yml.example` をコピーして作成できます。

4\. `files` ディレクトリの内容を新しいインストール先にコピーします(このディレクトリには、アップロードされたすべてのファイルがあります)。

5\. **自分で追加した**プラグインのフォルダを、`plugins` ディレクトリ(1.x からバージョンアップする場合は `vendor/plugins` ディレクトリ)から、新しいインストール先の `plugins` ディレクトリにコピーします。以前の Redmine に最初から同梱されていたプラグインはコピーしないでください。

6\. 次のコマンドで、必要な gem をインストールします。

```sh
bundle config set --local without 'development test'
bundle install
```

インストールされるのは、データベースの設定ファイルで指定したアダプターに必要な gem だけです(たとえば config/database.yml で「mysql2」アダプターを使う場合は、mysql2 の gem だけがインストールされます)。別のデータベースのアダプターを使うように config/database.yml を変更したら、`bundle install` をもう一度実行してください。

Redmine 本体が必要としない gem(fcgi など)を読み込む場合は、Redmine のディレクトリの直下に Gemfile.local というファイルを作成できます。このファイルは `bundle install` の実行時に自動で読み込まれます。

7\. 新しい Redmine のルートディレクトリで、次のコマンドを実行します。

Redmine 2.x 以前からバージョンアップする場合は、次のファイルがあれば削除します。

- config/initializers/secret_token.rb

続けて、アプリケーションのディレクトリで次のコマンドを実行し、新しい秘密鍵を生成します。

```sh
bundle exec rake generate_secret_token
```

代わりに、この秘密鍵を config/secrets.yml に保存することもできます:\
http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml

8\. `public/themes` ディレクトリにインストールしたテーマがあるか確認します。そのままコピーしてもかまいませんが、新しいバージョンがないか確認するのが理想です。

とても重要: `config/settings.yml` を古いファイルで上書きしないでください。

### 方法 2 - SVN のチェックアウトからバージョンアップする

1\. Redmine のルートディレクトリに移動し、次のコマンドを実行します。

```sh
svn update
```

2\. 次のコマンドで、必要な gem をインストールします。

```sh
bundle update
```

## 手順 4 - データベースの更新

この手順では、データベースの内容が変わる可能性があります。新しい Redmine のディレクトリに移動し、データベースをマイグレーションします。

```sh
bundle exec rake db:migrate RAILS_ENV=production
```

プラグインをインストールしている場合は、プラグインのデータベースのマイグレーションも実行します。

```sh
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
```

## 手順 5 - 後片付け

1\. キャッシュを消去します。

```sh
bundle exec rake tmp:cache:clear RAILS_ENV=production
```

2\. アプリケーションサーバー(puma、thin、passenger など)を再起動します。

3\. 最後に、*「管理」→「ロールと権限」*で、新しい機能があればその権限を確認・設定します。

## よくある問題

### リポジトリの管理のエラー

reposman.rb にいくつかの新機能が追加されました。問題が起きる場合は、グループを指定しているか確認してください(--group=groupnamehere)。また、Redmine.pm をコピーしただけの場合は、[こちら](https://www.redmine.org/projects/redmine/wiki/Repositories_access_control_with_apache_mod_dav_svn_and_mod_perl)の手順をもう一度実行し、Apache の設定を更新してください。推奨する設定が変わっています。

### 新しい `secret_token.rb` の生成

バージョン 2.0.0 より前は、Cookie を使うセッションを動かすために、Redmine の `config` ディレクトリに `session_store.rb` を生成する必要がありました。

バージョン 2.0.0 以降は、`session_store.rb` があってはいけません。代わりに、次のコマンドで `secret_token.rb` を生成します。

```sh
bundle exec rake generate_secret_token
```

*注: Redmine のコードのリポジトリには config/initializers/secret_token.rb はありません。このファイルは上の rake コマンドで作成されます。*

### 関連情報

次の情報が Redmine のバージョンアップに役立つかもしれません。

- Redmine 1.x から SQLite でバージョンアップした後に、Wiki の履歴の表示でエラーが起きる: \[#12501](https://www.redmine.org/issues/12501) を参照
- [mod_fcgid for Apache2](http://httpd.apache.org/mod_fcgid/) で、Apache 2 で Rails を動かせました
- [Running Redmine on Apache](http://www.redmine.org/wiki/redmine/HowTo_configure_Apache_to_run_Redmine)
- [Notes about our 0.8.6 to 0.9.3 upgrade issues and how to resolve them](http://web.archive.org/web/20111214022108/http://www.cybersprocket.com/2010/project-management/upgrading-redmine-from-8-6-to-9-3/) —cybersprocket (2010-04-25)
- [Notes about our 0.9.6 to 1.0(RC) upgrade process](http://web.archive.org/web/20120610010521/http://www.cybersprocket.com/2010/tips-tricks/upgrading-redmine-from-0-9-6-to-1-0-0/) —cybersprocket (2010-08-14)
