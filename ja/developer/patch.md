---
source: Patch
translated_from_version: 8
---

# パッチ

パッチファイルは、Redmine への変更をすべて書き出した 1 つのファイルです。Redmine への変更を作成して共有するときは、この方法をお勧めします。

## パッチファイルの作成

Redmine のパッチは簡単に作成できます。次の手順に従ってください。

1.  Redmine の開発中のコードをダウンロードします。
2.  *変更を加えます。*
3.  Redmine のフォルダで `svn diff > PATCH_NAME.diff` を実行します(git の場合は `git diff > PATCH_NAME.diff`)。PATCH_NAME は、目的がわかる名前に変えます。
4.  パッチファイルをチケットにアップロードして共有します。

## パッチファイルの適用

パッチファイルは [patch](http://www.gnu.org/software/patch/) プログラムで適用できます。

1.  Redmine のディレクトリ(app、test、config のフォルダがあるディレクトリ)に移動します。
2.  `patch -p0 < PATCH_NAME.diff` を実行します(git の場合は `git apply PATCH_NAME.diff`)。
3.  メッセージにエラーがないか確認します。

コードの同じ箇所に変更があると、エラーが起きることがあります。コードのマージに慣れていれば、変更をマージしてみてください。そうでなければ、パッチを入手した場所かフォーラムで助けを求めてください。

## パッチファイルの取り消し

パッチファイルは [patch](http://www.gnu.org/software/patch/) プログラムで取り消せます。

1.  Redmine のディレクトリ(app、test、config のフォルダがあるディレクトリ)に移動します。
2.  `patch -p0 -R < PATCH_NAME.diff` を実行します(git の場合は `git apply -R PATCH_NAME.diff`)。
3.  メッセージにエラーがないか確認します。
