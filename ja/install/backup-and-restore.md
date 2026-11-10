---
source: RedmineBackupRestore
translated_from_version: 14
---

# バックアップと復元

## バックアップ

Redmine のバックアップには、次のものを含めます。

- データベース
- 添付ファイル(デフォルトでは、インストール先のディレクトリの `files` ディレクトリに保存されています)

### データベースのバックアップ

#### MySQL

`mysqldump` コマンドで、MySQL のデータベースの内容をテキストファイルにバックアップできます。例:

```text
/usr/bin/mysqldump -u <username> -p<password> -h <hostname> <redmine_database> > /path/to/backup/db/redmine.sql
```

`<username>`、`<password>`、`<hostname>`、`<redmine_database>` は、`config/database.yml` に書かれています。データベースのインストールの仕方によっては、`<host_name>` は不要です。

#### PostgreSQL

`pg_dump` コマンドで、PostgreSQL のデータベースの内容をテキストファイルにバックアップできます。例:

```text
/usr/bin/pg_dump -U <username> -h <hostname> -Fc --file=redmine.sqlc <redmine_database>
```

`<username>`、`<hostname>`、`<redmine_database>` は、`config/database.yml` に書かれています。データベースのインストールの仕方によっては、`<hostname>` は不要です。パスワードが必要な場合は、`pg_dump` コマンドが入力を求めます。

#### SQLite

SQLite のデータベースは 1 つのファイルにすべて入っているので、そのファイルを別の場所にコピーすればバックアップできます。

SQLite のデータベースのファイル名は、`config/database.yml` で確認できます。

### 添付ファイルのバックアップ

アップロードされたファイルは、すべて `attachments_storage_path`(デフォルトは `files/` ディレクトリ)に保存されます。このディレクトリの内容を別の場所にコピーすれば、簡単にバックアップできます。

<u>警告:</u> `attachments_storage_path` が `files/` 以外のディレクトリを指している場合があります。役に立たないバックアップにならないように、`$RAILS_ROOT/config/configuration.yml` の設定を必ず確認してください。\
このファイルはない場合があります(Redmine v5.0.4 の時点)。標準の値を変えるためのテンプレート `$RAILS_ROOT/config/configuration.yml.example` があるので、\
このファイルをコピーし、`$RAILS_ROOT/config/configuration.yml` という名前にします。\
筆者の Debian のパッケージでのインストールでは、添付ファイルは\
`/var/lib/redmine/default/files` に保存されています。\
このフォルダはファイルの検索で見つけられます。Wiki ページにファイルを添付するか、プロジェクトに文書を追加して、「\*\_filename.filextention」を探してください。筆者の場合、保存されたファイルの名前は 12 桁の数字 \<`yymmddhhmmss`\> で始まっていました。\
`Gemfile.lock` の場所も参考になります。筆者の場合は、フォルダの階層で 2 つ上の `/var/lib/redmine/` にありました。\
また、インストールしているプラグインによっては、保存先が別の場合があることにも注意してください。筆者の場合は [DMSF](https://www.redmine.org/plugins/redmine_dmsf) プラグインがそうでした。

### バックアップのスクリプトの例

毎日のバックアップに使える簡単なシェルスクリプトの例です(MySQL のデータベースを使っている場合)。

```text
# Database
/usr/bin/mysqldump -u <username> -p<password> <redmine_database> | gzip > /path/to/backup/db/redmine_`date +%Y-%m-%d`.gz

# Attachments
rsync -a /path/to/redmine/files /path/to/backup/files
```

## 復元

### データベースの復元

#### MySQL

たとえば、`2018-07-30.gz` という名前の gzip で圧縮したダンプファイルがある場合は、次のコマンドでデータベースを復元できます。

```text
gunzip -c 2018-07-30.gz | mysql -u <username> --password <redmine_database>
Enter password:
```

#### PostgreSQL

上の例のように `pg_dump` コマンドで `-Fc` オプションを使った場合は、`pg_restore` コマンドを使います。

```text
pg_restore -U <username> -h <hostname> -d <redmine_database> redmine.sqlc
```

そうでない場合は、テキストファイルを `psql` で復元できます。

```text
psql <redmine_database> < <infile>
```

#### SQLite

バックアップの場所からデータベースのファイルをコピーします。
