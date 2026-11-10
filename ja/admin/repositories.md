---
source: RedmineRepositories
translated_from_version: 64
---

# リポジトリ

## 基本情報

Redmine は、次のバージョン管理システム (SCM) との連携に標準で対応しています。

|  |  |  |
|----|----|----|
| **バージョン管理システム** | **対応バージョン** | **コメント** |
| [Bazaar](http://bazaar.canonical.com/en/) | 1.0.0.candidate.1 ～ 2.7.0 |  |
| [CVS](http://www.nongnu.org/cvs/) | 1.12.12、1.12.13 | 1.12 が必要。CVSNT では動きません |
| [Git](https://git-scm.com/) | 1.5.4.2 ～ 2.11.0 |  |
| [Mercurial](http://www.selenic.com/mercurial/) | 5.1 以降 | 5.1 より前の Mercurial への対応は、Redmine 6.1.0 で終了しました (#33784) |
| [Subversion](http://subversion.apache.org/) | 1.3 ～ 1.9.7 | 1.3 以降が必要。Subversion の Ruby バインディングには対応していません。Subversion 1.7.0 と 1.7.1 には不具合があります (#9541) |

<u>注 1</u>: 該当するバイナリを、**Redmine と同じホスト**に**必ず**インストールしてください。

たとえば、Redmine で Subversion のリポジトリにアクセスするには、Redmine のホストに svn のバイナリをインストールする必要があります。

<u>注 2</u>: 該当するバイナリを、Redmine から実行できるようにしてください。

方法は 2 つあります。

- 環境変数 `PATH` から直接使えるようにする
  - コマンド名がデフォルトと違うときは、Redmine の[設定ファイル](../install/install.md#SCM-settings)で設定し直せます
- Redmine の[設定ファイル](../install/install.md#SCM-settings)で、バイナリのフルパスを設定する

最後に、使うバージョン管理システムを、「管理」 > 「設定」 > 「リポジトリ」 > 「使用するバージョン管理システム」で有効にしてください。

## 既存のリポジトリをプロジェクトに関連付ける

プロジェクトの設定で「リポジトリ」のモジュールが有効になっていることを確認し、「リポジトリ」のタブを開いて「新しいリポジトリ」をクリックします。\
リポジトリに合ったバージョン管理システムを選択し、リポジトリのパスか URL を入力します。

**重要**: 初めてリポジトリを閲覧するときに、Redmine は既存のすべてのコミットの説明を取得してデータベースに保存します。\
これはリポジトリごとに 1 回だけですが、リポジトリに数百のコミットがあると、とても長い時間がかかる (タイムアウトすることもある) 場合があります。

これを避けるには、オフラインで実行します。\
Redmine にリポジトリを登録した後、次のコマンドを実行します。

```text
$ ./bin/rails runner "Repository.fetch_changesets" -e production
```

すべてのコミットが Redmine のデータベースに取得されます。

バージョン 0.9.x から、Web サービスの URL を呼び出して `fetch_changesets` を実行することもできます。

```text
http://redmine.example.com/sys/fetch_changesets?key=<WS key> (=> fetches changesets for all active projects)
http://redmine.example.com/sys/fetch_changesets?key=<WS key>&id=foo (=> fetches changesets for project foo only)
```

1 行目はすべての有効なプロジェクトの、2 行目はプロジェクト foo だけのコミットを取得します。[リポジトリ管理用の Web サービス](settings.md#Enable-WS-for-repository-management)を有効にし、[「APIキー」](settings.md#Repository-management-WS-API-key)の設定で決めた API キーを `key` に付けるのを忘れないでください。

例は [HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit](https://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit) を参照してください。

### Subversion のリポジトリ

一般的なプロトコル (`http:`、`svn:`、`file:` など) に対応しています。リポジトリの URL を入力するだけです。

例:

```text
http://host/path/to/the/repository
```

リポジトリに認証が必要なときは、ユーザー名とパスワードを指定できます。

注: `svn+ssh://` でリポジトリにアクセスするときは、svn+ssh を対話なしで動くように設定する必要があります。\
そのためには、ssh の認証に使う公開鍵と秘密鍵のペアを設定します。

### CVS のリポジトリ

次の項目を入力します。

- リポジトリの URL (パスか、`:pserver` などの接続文字列)
- モジュール名

例:

```text
:pserver:login:password@host:/path/to/the/repository
```

### Git のリポジトリ

([HowTo_Easily_integrate_a_ (SSH_secured)_GIT_repository_into_redmine](https://www.redmine.org/projects/redmine/wiki/HowTo_Easily_integrate_a_(SSH_secured)_GIT_repository_into_redmine) も参照してください。)

#### ローカルの環境の準備

Redmine で閲覧するには、**ベア**で**ローカル**のリポジトリが必要です。

ToDo リストの管理のプロジェクト「Donebox」を閲覧するとします。そのクローンの URL は `git://github.com/ook/donebox.git` です。\
Redmine を動かしているサーバーで、Redmine のサーバーを実行しているユーザーがアクセスできるディレクトリを作成します。

```text
$ sudo mkdir -p /var/redmine/git_repositories
$ sudo chown rails:rails /var/redmine/git_repositories
$ cd /var/redmine/git_repositories
```

2 行目に注意してください。作成したディレクトリの所有者を、ユーザー `rails` とグループ `rails` に変更しています。もちろん、サーバーの設定に合わせて置き換える必要があります (`www-data`、`apache`、または管理がとてもまずいサーバーでは `root` など)。このユーザーには、`git` コマンドを実行する (ローカルの) 権限が必要です。

#### ベアリポジトリの作成

上の手順が済んだら、ベアリポジトリを作成します。

```text
$ pwd
/var/redmine/git_repositories
$ git clone --bare git://github.com/ook/donebox.git donebox.git
Initialized empty Git repository in /var/redmine/git_repositories/donebox.git/
remote: Counting objects: 401, done.
remote: Compressing objects: 100% (246/246), done.
remote: Total 401 (delta 134), reused 401 (delta 134)
Receiving objects: 100% (401/401), 179.55 KiB | 185 KiB/s, done.
Resolving deltas: 100% (134/134), done.
$ cd donebox.git
```

これでベアリポジトリができました。Redmine のプロジェクトの設定で「リポジトリ」のタブを開き、バージョン管理システムに `git` を選択し、*リポジトリのパス* (この例では `/var/redmine/git_repositories/donebox.git/`) を入力して設定を保存します。プロジェクトの「リポジトリ」のタブを開くと、リポジトリを閲覧できるはずです。

注: 不具合 [#8548](https://www.redmine.org/issues/8548) により、*ファイルとディレクトリの最新コミットを表示する*を設定すると、リポジトリのファイルとディレクトリの一覧に次の 4 つの列が追加されます。

- リビジョン
- 経過期間
- 作成者
- コメント

注: もちろん、この Git のリポジトリは自動では更新されません。定期的に手で `git fetch` するか、`git fetch` コマンドを自動で実行する cron ジョブを設定する必要があります。

リポジトリ (とすべてのブランチ) を 10 分ごとに更新するには、次のような cron ジョブを追加します。

```text
*/10 * * * * cd /srv/repos/git/myrepo.git && git fetch origin +refs/heads/*:refs/heads/* && git reset --soft
```

または、次のような post-receive フックを使います。

```text
echo "Post receive-hook => updating Redmine repository"
sudo -u my_redmine_user -p secret perl -we '`cd /redmine/repositories/my_repo.git && git fetch && git reset --soft refs/remotes/origin/master`'
```

git reset に注意してください。Git のツリーを更新して、変更を「リポジトリ」の画面に表示するには、これが**必要です**。ベアリポジトリなので「soft」のオプションが必要です。デフォルトのオプション (mixed) は、作業ツリーがないため失敗します。

GitHub を使っているときは、[Github Hook Plugin](https://www.redmine.org/projects/redmine/wiki/Plugin_List#Github-Hook-plugin) を使えます。

#### Windows のベアリポジトリ

ベアリポジトリを **Windows** にインストールしているときは、環境変数 %%PATH%% に次を追加します。\
`;%GIT_PATH%\cmd;%GIT_PATH%\bin;`\
%%GIT_PATH%% は Git のインストール先のディレクトリです (例: *C:/Git*)。

#### ミラーリポジトリの設定 (近道、追跡ブランチ)

上の方法はほとんどの場合にうまく動きますが、master 以外のブランチもあるときは、うまく動かすのに多くの調整が必要になることがあります。この問題と解決方法について詳しくは、[Stack Overflow の質問](http://stackoverflow.com/questions/4698649/how-do-i-get-a-remote-tracking-branch-to-stay-up-to-date-with-remote-origin-in-a)を参照してください。

この方法では、リポジトリの origin のブランチを最新の状態に保ち、Redmine のリポジトリブラウザーに表示できます。これが意味を持つのは、リポジトリのローカルのコピーを、Redmine で使う読み取り専用のコピーとしてだけ使う場合です。たとえば、プロジェクトは GitHub でホストし、チケットトラッキングには Redmine を使う場合です。

```text
$ pwd
/var/redmine/git_repositories
$ git clone --mirror git://github.com/ook/donebox.git donebox.git
Initialized empty Git repository in /var/redmine/git_repositories/donebox.git/
remote: Counting objects: 717, done.
remote: Compressing objects: 100% (561/561), done.
remote: Total 717 (delta 320), reused 371 (delta 134)
Receiving objects: 100% (717/717), 211.35 KiB | 86 KiB/s, done.
Resolving deltas: 100% (320/320), done.
$ cd donebox.git
$ git branch
  WW
  asap
  bugcat
  comeback
* master
```

この方法は、git clone コマンドの `--mirror` のオプションを使います。古いバージョンの Git には、このオプションがないことがあります。その場合は、`--mirror` のオプションを使わずにこの種類のミラーを設定する方法について、[Stack Overflow の質問](http://stackoverflow.com/questions/4698649/how-do-i-get-a-remote-tracking-branch-to-stay-up-to-date-with-remote-origin-in-a)を参照してください。

### Mercurial のリポジトリ

Mercurial のリポジトリと同期するには、Redmine をインストールしたサーバーに、リポジトリのローカルのクローンが必要です。Redmine を /var/www/redmine.example.com/www に、Mercurial のリポジトリを /var/www/sources.example.com/repo/example に置いたとします。この場合、バージョン管理システムに **Mercurial** を選択し、リポジトリの入力欄に **/var/www/sources.example.com/repo/example** を入力します。

Mercurial のリポジトリの読み込みが始まりますが、結果はすぐには表示されません。数秒 (場合によっては数分) 待ってから、プロジェクトの「リポジトリ」のタブ (設定の画面のタブではありません) をクリックします。結果が表示されるはずです。

Redmine は外部のリポジトリを同期 (push/pull) しません。更新を取得する前に同期するスクリプトを設定できます。\
hgsync.sh:

```text
#!/bin/bash
for file in /var/www/sources.example.com/*; do
   if [ -d $file ]; then
      cd $file; hg pull -u
   fi
done
```

### Bazaar のリポジトリ

「リポジトリのパス」に、リポジトリのフルパスを入力します。\
例: /home/username/bzr/repo/trunk

bzr が ENV\[’PATH’\] から、bzrlib が ENV\[’PYTHONPATH’\] から見つかるようにする必要があります。\
たとえば、config/environment.rb を編集して次を追加します。

```text
ENV['PYTHONPATH'] = '/path/to/pythonlib'
ENV['PATH'] = "#{ENV['PATH']}:/path/to/bzr/bin"
```

## リポジトリのユーザーの対応付け

プロジェクトの「設定」 > 「リポジトリ」で、それぞれのリポジトリの行に「ユーザー」というリンクがあります。

このリンクで、コミットしたユーザーを Redmine のユーザーに対応付けます。ログイン ID かメールアドレスが一致するときは自動で対応付けられます。一致しないときは、リポジトリのユーザーと Redmine のユーザーの対応を設定する必要があります。

これは、時間管理を動かすのに必要です。
