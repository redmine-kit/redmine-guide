---
source: RedmineMigrate
translated_from_version: 34
---

# ほかのシステムからの移行

## Trac

**廃止: 動作しません**

Trac のインポーターは、次のものを移行します。

- ユーザー
- コンポーネント
- マイルストーン
- チケット
- チケットのコメントと変更(ステータスと解決状況)
- Trac 固有のフィールド(解決状況など)は、Redmine のカスタムフィールドとして追加されます
- チケットのファイルとカスタムフィールド
- 履歴を含む Wiki ページ

注:

1.  ユーザーのパスワードはすべて `trac` になります
2.  Redmine のデータベースにまだチケットがなければ、チケットの ID はそのまま引き継がれます
3.  カスタムフィールドは、すべて Redmine のテキストのカスタムフィールドとして作成されます

Trac のデータベースにアクセスするには、sqlite-ruby の gem が必要です。

\- sqlite の場合: `gem install sqlite-ruby`\
- sqlite3 の場合: `gem install sqlite3-ruby`

始める前に、**デフォルトデータを読み込んだ(必須)** 新しい Redmine のデータベースを用意します。[Redmine のインストール](install.md)を参照してください。

このスクリプトは、Trac 0.10 の sqlite のデータベースと、Trac 0.11 の sqlite3 のデータベースで試験されています。

1\. 次のコマンドを実行します。test は移行先の Redmine の環境です。

rake redmine:migrate_from_trac RAILS_ENV=”test”

2\. スクリプト([source:trunk/lib/tasks/migrate_from_trac.rake](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/tasks/migrate_from_trac.rake))が Trac の設定を尋ねます。

```text
Trac directory []: /var/trac/myproject
Trac database adapter (sqlite, sqlite3, mysql, postgresql) [sqlite]:
Database encoding [UTF-8]:
Target project identifier []: myproject
```

Trac directory は、Trac の環境のルートディレクトリです。Redmine はこのディレクトリで `db/trac.db`(sqlite/sqlite3 のデータベースを選んだ場合)と `attachments` ディレクトリを探します。\
Trac のデータベースが mysql か postgresql の場合は、接続のパラメーター(ホスト、データベース名、ユーザー名、パスワード)を尋ねます。\
Target project identifier は、データを読み込む Redmine のプロジェクトの識別子です(プロジェクトがなければ作成されます)。

3\. スクリプトがデータを移行します。

```text
Deleting data
Migrating components..............................
Migrating milestones..............
Migrating custom fields.......
Migrating tickets.................................
Migrating wiki...........

Components: 29/30
Milestones: 14/14
Tickets: 1275/1275
Ticket files: 106/106
Custom values: 4409/4409
Wiki edits: 102/102
```

スクリプトは、移行したオブジェクトの総数を表示します。\
これで、Redmine に Myproject というプロジェクトができ、Trac のデータが読み込まれています。

## Mantis

**廃止: 動作しません**

Mantis のインポーターは、次のものを移行します。

- ユーザー
- プロジェクト
- プロジェクトのバージョン、カテゴリ、ニュース
- プロジェクトのメンバー
- バグ
- バグのノート、ファイル、関連、モニター
- カスタムフィールド

ユーザーのパスワードはすべて「mantis」になります。

バグのファイルを移行できるのは、ファイルが Mantis のデータベースに保存されている場合だけです(これが Mantis のデフォルトの動作です)。

このスクリプトは、Mantis 1.0.x のいくつかのデータベースで試験されており、ほかの最近のバージョンでも動くはずです。

始める前に、**デフォルトデータを読み込んだ(必須)** 新しい Redmine のデータベースを用意します。[Redmine のインストール](install.md)を参照してください。\
データの入っている Redmine のデータベースに移行する場合は、[Ulrichs](email://uk@fortrabbit.de) の [Non-destructive migration Script](http://blog.foaa.de/2010/04/non-destructive-migration-from-mantis-to-redmine/) を使えます。

パッチ [#10504](https://www.redmine.org/issues/10504) を必ず適用してください。

1\. 次のコマンドを実行します。test は移行先の Redmine の環境です。

rake redmine:migrate_from_mantis RAILS_ENV=”test”

2\. スクリプトが Mantis のデータベースの設定を尋ねます。

```text
Please enter settings for your Mantis database
adapter [mysql]:
host [localhost]:
database [bugtracker]: mantis
username [root]:
password []:
encoding [UTF-8]:
```

Mantis のデータベースのアダプター、ホスト名、データベース名、ログインID、パスワード、エンコーディングを入力するか、デフォルトの値のままにします。

アダプターは mysql(デフォルト)か postgresql です。

3\. スクリプトがデータを移行します。

```text
Migrating users...............
Migrating projects.............
Migrating bugs........................................
Migrating news...
Migrating custom fields..

Users: 15/15
Projects: 13/13
Memberships: 10/10
Versions: 33/33
Categories: 4/4
Bugs: 180/180
Bug notes: 336/336
Bug files: 46/46
Bug relations: 11/11
Bug monitors: 8/8
News: 3/3
Custom fields: 2/2
```

スクリプトは、移行したオブジェクトの総数を表示します。

## ほかのシステムとサードパーティのスクリプト

Redmine の利用者が作成したほかのインポーターもあります。

- [Non-destructive migration from Mantis to Redmine](http://blog.foaa.de/2010/04/non-destructive-migration-from-mantis-to-redmine/)\
  \> \* サポートは終了しています
- Jira のインポーター: [#1385](https://www.redmine.org/issues/1385)
- Bugzilla のインポーター: [#989](https://www.redmine.org/issues/989) 現在、Bugzilla のインポーターは 2 つあります。bz2redmine http://github.com/ralli/bz2redmine と migrate_from_bugzilla http://github.com/ralli/migrate_from_bugzilla です。bz2redmine は Bugzilla の元のバグ番号を引き継ぎます。migrate_from_bugzilla の rake タスクは ActiveRecord を使い、postgresql のデータベースとの間の移行にも使えます。
- Scarab のインポーター: [#2928](https://www.redmine.org/issues/2928)
- 別の Redmine からプロジェクトを移行する: https://github.com/PowerKiKi/redmine-tools\
  -\* [A trick to import data from Mantis](http://dotnetmarche.org/blogs/externalblogs/archive/2009/05/29/redmine-a-trick-to-import-data-from-mantis.aspx-)
- phpBugTracker-1.0.5 から Redmine 2.5 への移行: https://github.com/ottodude125/migrate_from_phpbt_to_redmine - 同じではありませんが、Mantis のインポートのスクリプトと似たところがあります

これらのスクリプトは、試験もサポートもされていません。
