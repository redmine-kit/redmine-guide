---
source: Contribute
translated_from_version: 53
---

# Redmine への貢献

Redmine は、コミュニティのボランティアが開発し、メンテナンスしています。Redmine を気に入って使っていて、コミュニティに恩返しをしたい場合は、いくつかの方法でプロジェクトに貢献できます。より具体的なアイデアは、フォーラムのスレッド [How to contribute](https://www.redmine.org/boards/1/topics/4325) も読んでください。

## コントリビューター

[Teams](https://www.redmine.org/projects/redmine/wiki/Teams) のページで、さまざまな役割の概要がわかります。\
Redmine の現在のコントリビューターと作者の一覧は、[概要のページ](http://www.redmine.org/projects/redmine)のメンバーの一覧で確認できます。\
コードの活動は、[リポジトリの統計のページ](http://www.redmine.org/projects/redmine/repository/statistics)でも追えます。

## コードに関わる貢献

これらには Ruby on Rails の開発の経験が必要です。Rails に慣れていなくても、行き詰まったときや疑問があるときは、コミュニティのメンバーが手伝ってくれます。

現在の開発中のコードを手元に用意する必要があります。公式のコードのリポジトリは Subversion にあり、[ダウンロード](../install/download.md)の手順でダウンロードできます。

開発に Mercurial や Git を使う場合のために、ソースは [Bitbucket](https://bitbucket.org/redmine)(コミュニティが管理)と [GitHub](http://github.com/redmine/redmine)(コミュニティが管理)にミラーされています。

質問は、[フォーラム](http://www.redmine.org/projects/redmine/boards/1)や、IRC の[開発チーム](https://www.redmine.org/projects/redmine/wiki/Teams)に尋ねてください。

### パッチの確認

古くなったパッチを最新のコードにきれいに適用できるように直す作業は、とても助かります。パッチの付いたチケットは多くありますが、その多くは最新のバージョンでは動きません。

未解決のパッチの一覧は [Patch Queue](http://www.redmine.org/projects/redmine/issues?query_id=931) を参照してください。\
「Patch」は、パッチを含むチケットのための、Redmine.org の独自の[トラッカー](../admin/issue-tracking-setup.md#Trackers)です。

### コードのドキュメント

[RDoc](http://rdoc.sourceforge.net/) でクラスとメソッドを文書化すると、開発者が Redmine の仕組みを理解しやすくなります。Redmine をインストールしたら、`bin/rake yard` を実行すると、最新のドキュメント (YARD) が `doc/app` に生成されます。ドキュメントのない、または不十分なメソッドへのパッチは役に立ち、手軽な貢献の方法です。[ドキュメントのチケットの一覧](http://www.redmine.org/projects/redmine/issues?query_id=84*)\*

### 開発

不具合の修正や新機能の追加のパッチは、いつでも歓迎します。特定のチケットに取り組む場合は、そのチケットにコメントを書き、何に取り組んでいるかを開発者がわかるようにしてください。

### コードで貢献する基本の流れ:

1.  **svn の trunk**、**Mercurial の default の名前付きブランチ**、または **Git の master ブランチ**で作業していることを確認します。\
    安定バージョンのリリースへのパッチは受け付けていません。誰かがパッチをまず trunk に移植し、それから安定バージョンに戻して移植することになる(つまり作業が 2 倍になる)ためです。\
    Mercurial を使う場合は、[graft](http://www.selenic.com/hg/help/graft) や [mercurial queues extension](http://mercurial.selenic.com/wiki/MqExtension) を使えます。
2.  Redmine には**テスト**([source:trunk/test](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/test))があります。既存のテストがすべて通ることを確認します。現在のビルドの状態は [Redmine Continuous Integration server](https://www.redmine.org/projects/redmine/wiki/Continuous_integration) で確認できます。すべてのテストは「rake test」で、個別のテストは「ruby test/unit/issue_test.rb」で実行できます。詳しくは [source:trunk/doc/RUNNING_TESTS](https://www.redmine.org/projects/redmine/repository/svn/show/trunk/doc/RUNNING_TESTS) を参照してください。
3.  新しい機能を示し、不具合を確認するテストを追加します。
4.  パッチをチケットに投稿します。\
    **<span style="color: red">GitHub や Bitbucket でプルリクエストを送らないでください</span>**。\
    Mercurial や Git を使う場合は、パッチシリーズを作成できます。\
    [Mercurial と Git でのパッチシリーズの作成](how-to-create-patch-series-on-mercurial-and-git.md)を参照してください。
5.  利用者と開発者にフィードバックを求めます。利用者はパッチを適用して新しい機能を試し、開発者はコードをレビューしてすべてのテストを実行します。
6.  提案された変更について議論し、必要に応じて新しいパッチを投稿します。

## コード以外の貢献

これらにはソフトウェア開発の経験は不要です。時間と、手伝いたいという気持ちがあれば十分です。

### 利用者のサポート

[フォーラム](http://www.redmine.org/projects/redmine/boards)や IRC のチャンネル(#redmine @ freenode)でほかの利用者を手伝うことは、いつでも役に立ちます。よくある問題や質問は取り上げて、これからの利用者のために Wiki を更新できるようにしてください。

### ローカライズのサポート

[翻訳](https://www.redmine.org/projects/redmine/wiki/HowTo_translate_Redmine_in_your_own_language)は、Redmine の開発に合わせて最新に保つ必要があります。必要に応じて翻訳の更新を提供したり、Redmine の I18n のサポートのために提案したりできます。[ローカライズと翻訳のチケットの一覧](http://www.redmine.org/projects/redmine/issues?query_id=7*)\*

### チケットの選別

チケットが、[開発者に必要な情報](submissions.md#Submitting-a-Bug)をすべて含まずに報告されることがあります。報告者やコミュニティから不具合や機能の詳細を聞き出すと、何が必要かを全員が理解しやすくなります。自分の Redmine で不具合を再現できる場合は、Redmine のバージョンと、実際に行った正確な手順をコメントに書いてくれると、とても役に立ちます。

### デザインとユーザーインターフェース

Redmine のデザインとユーザーインターフェースは、とても基本的なものです。新しいテーマ、スキン、インターフェースの調整など、どんな改善も Redmine のすべての利用者の役に立ちます。[UI / UX Team](https://www.redmine.org/projects/redmine/wiki/UX_Team) に参加してください。
