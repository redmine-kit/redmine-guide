---
source: MySQL_configuration
translated_from_version: 10
---

# MySQL の設定

MySQL 5.6、5.7、8.0、8.1、またはそれに相当するバージョンの MariaDB をデータベースに使う Redmine には、チケットの入れ子集合を同時に変更したとき(つまり、複数のチケットの parent_id を並行して変更したとき)の既知の問題があります。詳しくはチケット [#39437](https://www.redmine.org/issues/39437) と、それに関連するチケットを参照してください。

Redmine 5.1.1 以降には、この問題を軽減する重要な修正(r22458、r22459、r22460)が入っています。ただし、これらの修正が正しく働くには、`transaction_isolation` を `READ COMMITTED` に変える必要があります。[公式のドキュメント](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html)によると、MySQL のデフォルトのトランザクション分離レベルは `REPEATABLE READ` です。

トランザクション分離レベルを恒久的に `READ-COMMITTED` に変える方法は、少なくとも 2 つあります。

**1. Redmine のデータベースの設定ファイルを変更する**

設定ファイル `database.yml` に、次のようにキー `variables` を追加し、その下に `transaction_isolation: "READ-COMMITTED"` を書きます。

```yml
production:
  adapter: mysql2
  database: redmine
  host: localhost
  [...]
  variables:
    # For MySQL version 5.7.20 or older, use tx_isolation instead of transaction_isolation here.
    transaction_isolation: "READ-COMMITTED"
```

**2. サーバーの MySQL の設定ファイルで `transaction_isolation` を変更する**

```conf
transaction_isolation="READ-COMMITTED"
```

- このファイルのパスは OS によって異なります。たとえば Ubuntu では `/etc/mysql/conf.d/mysql.cnf` です。
- この設定を変更するには、データベースサーバーの再起動が必要です。サーバーを再起動しない場合は、クエリ `SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;` を実行して、実行中のサーバーに設定を適用することもできます。ただし、再起動の後も設定が残るように、設定ファイルも必ず変更してください。
- 主要なクラウドプロバイダーはどれも、クラウドの管理画面からこの設定を変更できます。

本番のシステムへのほかの変更と同じように、この変更も本番に適用する前に試験することを強くお勧めします。レプリカのある高度な構成では、この変更でサーバーのバイナリログの形式も変わる場合があります。`READ COMMITTED` の分離レベルでは、行ベースのバイナリログだけがサポートされているためです。
