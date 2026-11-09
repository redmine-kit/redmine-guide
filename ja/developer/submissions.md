---
source: Submissions
translated_from_version: 30
---

# redmine.org への投稿

投稿は英語で書いてください。

## 不具合の報告

ここで不具合を報告する前に、次のことを確認してください。

- 適切なバージョンの Rails を使っていること([RedmineInstall](../install/install.md) を参照)
- データベースが最新であること。特に、以前のバージョンやリビジョンから移行した直後は注意してください([RedmineUpgrade](../install/upgrade.md) を参照)
- 問題が svn(またはほかの SCM)に関係する場合は、Redmine のホストに適切なコマンドがインストールされていること([RedmineRepositories](../admin/repositories.md) を参照)

また、[不具合の一覧](http://www.redmine.org/projects/redmine/issues?query_id=1)と [FAQ](https://www.redmine.org/projects/redmine/wiki/FAQ) を見て、すでに報告されていないか確認してください。

不具合を報告するときは、問題の説明と一緒に次の情報を書いてください。

- データベース管理システムのバージョン(例: PostgreSQL 9.2)
- Ruby のバージョン(例: Ruby 3.2.2)
- Redmine のバージョン(「Affected version」でバージョン番号を選びます)と、リポジトリのコードを使っている場合は正確なリビジョン(例: r22769)
- 問題が SCM との連携に関するものであれば、SCM のコマンドのバージョン(例: svn 1.14.3、git 2.44.0)
- 使っているプラグイン(例: Code Review プラグイン)

環境の情報を得るいちばん簡単な方法は、Redmine のインストール先で次のコマンドを実行することです。

```sh
ruby bin/about
```

アプリケーションのエラーを報告するときは、ログファイル(例: `log/production.log`)にあるエラーのスタックトレースをすべて貼り付けてください。アプリケーションが表示するメッセージ(例: *…An error occurred on the page you were trying to access…*)は役に立ちません。

報告するエラーが rake タスク(例: `rake db:migrate`)の実行中に起きる場合は、`--trace` オプションを付けてタスクを実行し直し(例: `rake db:migrate --trace`)、出力をすべて貼り付けてください。

Debian/Ubuntu の `redmine` パッケージ、Bitnami の VM、ビルド済みの Docker イメージなど、外部のパッケージマネージャーで Redmine をインストールした場合は、問題の原因が Redmine そのものにあると確信できる場合を除き、それぞれのパッケージのサポート窓口に問い合わせてください。これらのパッケージは Redmine のチームがメンテナンスしているものではありません。独自の変更が加えられていたり、特別なセットアップの手順が必要だったりすることが多く、私たちはそれを把握しておらず、通常は手助けできません。

## セキュリティの脆弱性の報告

セキュリティの脆弱性を見つけたと思ったら、`security(at)redmine.org` にメールで報告してください。Redmine のリリースで修正された既知の脆弱性は、[Security Advisories](https://www.redmine.org/projects/redmine/wiki/Security_Advisories) に一覧があります。

## 機能の要望

ここで機能を要望する前に、次のことを確認してください。

- 「題名」に、説明の要約を書きます
- 「説明」には、できるだけ詳しく書きます。機能がどう動くべきかを遠慮なく正確に書き、その機能で期待する利点も書いてください
- 「対象バージョン」は**入力しないでください**。いつ取り込むかは開発者が決めます
- 機能の要望を誰にも**割り当てないでください**。扱いは開発者に任せてください

## Wiki の改善

Wiki のページを編集して内容を改善するときは、「コメント」に、ページに加えた変更の要約をわかりやすく書いてください。そうすると、Wiki の内容の品質を「見守り」「維持する」のに役立ちます。

## パッチの投稿

- 変更は 1 つのパッチファイルで投稿してください。svn でパッチを作成する手順は[こちら](patch.md)にあります。
- パッチの元になったブランチ/リビジョンを書き、パッチを添付してください
