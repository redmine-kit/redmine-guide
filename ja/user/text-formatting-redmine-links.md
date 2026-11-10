---
source: RedmineTextFormattingRedmineLinks
translated_from_version: 9
---

# Redmine のリンク

Redmine では、テキスト書式を使うすべての場所から、リソース(Wikiページ、チケット、文書など)へのハイパーリンクを作成できます。

Wiki のリンク:

- **\[\[Guide\]\]** は、「Guide」という名前のページへのリンクを表示します: [Guide](https://www.redmine.org/projects/redmine/wiki/Guide)
- **\[\[Guide#further-reading\]\]** は、アンカー「further-reading」に移動します。見出しには自動でアンカーが付くため、見出しを参照できます: [Guide#further-reading](https://www.redmine.org/projects/redmine/wiki/Guide#further-reading)
- **\[\[Guide\|User manual\]\]** は、同じページへのリンクを別のテキストで表示します: [User manual](https://www.redmine.org/projects/redmine/wiki/Guide)
- **\[\[Guide#User-guide\|User guide\]\]** は、同じページの見出しへのリンクを別のテキストで表示します: [User guide](https://www.redmine.org/projects/redmine/wiki/Guide#User-guide)

ほかのプロジェクトの Wiki のページにもリンクできます(プロジェクトの識別子を使います)。

- **\[\[sandbox:some page\]\]** は、Sandbox の Wiki の「Some page」という名前のページへのリンクを表示します
- **\[\[sandbox:\]\]** は、Sandbox の Wiki のメインページへのリンクを表示します

まだ存在しないページへの Wiki のリンクは、赤で表示されます。例: [Nonexistent page](https://www.redmine.org/projects/redmine/wiki/Nonexistent_page)

ほかのリソースへのリンク:

- チケット:
  - **#124**(チケットへのリンク: [#124](https://www.redmine.org/issues/124) と表示されます。チケットが完了している場合は、リンクに取り消し線が付きます)
  - **#124-6** または **#124#note-6**(チケットのコメントへのリンク: [#124](https://www.redmine.org/issues/124)-6 または [#124](https://www.redmine.org/issues/124)#note-6 と表示されます)
  - **##124**(トラッカーと題名を含むチケットへのリンク: \##124 と表示されます)
  - **#note-6**(同じチケットの中のコメントへのリンク)
- 文書:
  - **document#17**(ID が 17 の文書へのリンク)
  - **document:Greetings**(タイトルが「Greetings」の文書へのリンク)
  - **document:”Some document”**(文書のタイトルに空白が含まれる場合は、ダブルクォーテーションで囲めます)
  - **sandbox:document:”Some document”**(識別子が「sandbox」のプロジェクトにある、タイトルが「Some document」の文書へのリンク)
- バージョン:
  - **version#3**(ID が 3 のバージョンへのリンク)
  - **version:1.0.0**(名称が「1.0.0」のバージョンへのリンク)
  - **version:”1.0 beta 2”**(バージョンの名称に空白が含まれる場合は、ダブルクォーテーションで囲めます)
  - **sandbox:version:1.0.0**(識別子が「sandbox」のプロジェクトにある、バージョン「1.0.0」へのリンク)
- 添付ファイル:
  - **attachment:file.zip**(表示中のオブジェクトの、file.zip という名前の添付ファイルへのリンク)
  - **attachment:”file name.zip”**(ファイル名に英数字以外の文字が含まれる場合は、ダブルクォーテーションで囲めます)
  - 今のところ、参照できるのは表示中のオブジェクトの添付ファイルだけです(チケットを表示している場合は、そのチケットの添付ファイルだけを参照できます)
- リビジョン:
  - **r758**(リビジョンへのリンク。[r758](https://www.redmine.org/projects/redmine/repository/svn/revisions/758) と表示されます)
  - **commit:c6f4d0fd**(数字ではないハッシュのリビジョンへのリンク)
  - **svn1\|r758**(特定のリポジトリのリビジョンへのリンク。複数のリポジトリがあるプロジェクトで使います)
  - **commit:hg\|c6f4d0fd**(特定のリポジトリの、数字ではないハッシュのリビジョンへのリンク)
  - **sandbox:r758**(ほかのプロジェクトのリビジョンへのリンク)
  - **sandbox:commit:c6f4d0fd**(識別子で指定したほかのプロジェクトの、数字ではないハッシュのリビジョンへのリンク)
- リポジトリのファイル:
  - **source:some/file**(プロジェクトのリポジトリの /some/file にあるファイルへのリンク)
  - **source:”some file”**(パスに英数字以外の文字が含まれるファイルへのリンク)
  - **source:some/file@52**(ファイルのリビジョン 52 へのリンク)
  - **source:some/file@master**(ブランチ *master* のファイルへのリンク)
  - **source:some/file#L120**(ファイルの 120 行目へのリンク)
  - **source:some/file@52#L120**(ファイルのリビジョン 52 の 120 行目へのリンク)
  - **source:repo_identifier\|some/file**(特定のリポジトリのファイルへのリンク。複数のリポジトリがあるプロジェクトで使います)
  - **sandbox:source:some/file**(識別子が「sandbox」のプロジェクトにあるファイルへのリンク)
  - **sandbox:source:repo_identifier\|some/file**(識別子が「sandbox」のプロジェクトの特定のリポジトリにある、パスに英数字以外の文字が含まれるファイルへのリンク)
  - **export:some/file**(ファイルを強制的にダウンロードさせます)
- フォーラム:
  - **forum#2**(ID が 2 のフォーラムへのリンク)
  - **forum:Discussion**(名称が「Discussion」のフォーラムへのリンク)
  - **forum:”Help and more”**(フォーラムの名称に空白が含まれる場合は、ダブルクォーテーションで囲めます)
- フォーラムのメッセージ:
  - **message#1218**(ID が 1218 のメッセージへのリンク)
- ニュース
  - **news#1**(ID が 1 のニュースへのリンク)
  - **news:Greetings**(名称が「Greetings」のニュースへのリンク)
  - **news:”eCookbook first release !”**(ニュースの名称に空白が含まれる場合は、ダブルクォーテーションで囲めます)
- プロジェクト:
  - **project#3**(ID が 3 のプロジェクトへのリンク)
  - **project:someproject**(名称が「someproject」のプロジェクトへのリンク)
  - **project:”Multiple words project”**(プロジェクトの名称に空白が含まれる場合は、ダブルクォーテーションで囲めます)
- ユーザー:
  - **user#2**(ID が 2 のユーザーへのリンク)
  - **user:jsmith**(ログインIDが「jsmith」のユーザーへのリンク)
  - **@jsmith**(ログインIDが「jsmith」のユーザーへのリンク)

エスケープ:

- 感嘆符を前に付けると、Redmine のリンクとして解析されないようにできます: !
