---
source: Rest_api
translated_from_version: 106
---

# Redmine API

Redmine は、データの一部を REST API で公開しています。この API では、以下のリソースにアクセスし、基本的な CRUD の操作(作成、更新、削除)を行えます。API は [XML](http://en.wikipedia.org/wiki/Xml) と [JSON](http://en.wikipedia.org/wiki/JSON) の両方の形式に対応しています。

## API の一覧

| リソース | 状態 | 備考 | 利用できるバージョン |
|----|----|----|----|
| [チケット](rest-issues.md) | 安定 |  | 1.0 |
| [プロジェクト](rest-projects.md) | 安定 |  | 1.0 |
| [メンバー](rest-memberships.md) | アルファ |  | 1.4 |
| [ユーザー](rest-users.md) | 安定 |  | 1.1 |
| [作業時間](rest-time-entries.md) | 安定 |  | 1.1 |
| [ニュース](rest-news.md) | 安定 | `index` 以外の CRUD の操作は 4.1 で追加 | 1.1 |
| [関連するチケット](rest-issue-relations.md) | アルファ |  | 1.3 |
| [バージョン](rest-versions.md) | アルファ |  | 1.3 |
| [Wikiページ](rest-wiki-pages.md) | アルファ |  | 2.2 |
| [文書](rest-documents.md) |  | Redmine 7.0.3 では利用できません | 7.1 |
| [カスタムクエリ](rest-queries.md) | アルファ |  | 1.3 |
| [添付ファイル](rest-attachments.md) | ベータ | API による添付ファイルの追加は 1.4 で追加 | 1.3 |
| [チケットのステータス](rest-issue-statuses.md) | アルファ | すべてのステータスの一覧を返す | 1.3 |
| [トラッカー](rest-trackers.md) | アルファ | すべてのトラッカーの一覧を返す | 1.3 |
| [選択肢の値](rest-enumerations.md) | アルファ | チケットの優先度と作業分類の一覧を返す | 2.2 |
| [チケットのカテゴリ](rest-issue-categories.md) | アルファ |  | 1.3 |
| [ロール](rest-roles.md) | アルファ |  | 1.4 |
| [グループ](rest-groups.md) | アルファ |  | 2.1 |
| [カスタムフィールド](rest-custom-fields.md) | アルファ |  | 2.4 |
| [検索](rest-search.md) | アルファ |  | 3.3 |
| [ファイル](rest-files.md) | アルファ |  | 3.4 |
| [個人設定](rest-my-account.md) | アルファ |  | 4.1 |
| [履歴](rest-journals.md) | アルファ |  | 5.0 |

状態の凡例:

- 安定 - 機能は完成しており、大きな変更の予定はありません
- ベータ - 連携に使えますが、いくつかの不具合や、小さな機能の不足があります
- アルファ - 主な機能はそろっていますが、API の利用者や連携の開発者からのフィードバックが必要です
- プロトタイプ - ごく粗い実装で、バージョンの途中で互換性のない大きな変更が入る可能性があります。**連携には推奨しません**
- 予定 - 開発者の都合しだいで、将来のバージョンで予定しています

[バージョン別の API の変更](https://www.redmine.org/projects/redmine/issues?set_filter=1&status_id=c&fixed_version_id=*&category_id=32&c[]=tracker&c[]=subject&c[]=author&group_by=fixed_version&sort=fixed_version:desc,id)の一覧をすべて確認できます。

## 共通の事項

### `POST`/`PUT` のリクエストでの `Content-Type` の指定

リモートの要素を作成・更新するときは、URL に対応する拡張子が付いていても(例: `POST ../issues.json`)、リクエストの `Content-Type` を**必ず**指定してください。

- JSON の場合は `Content-Type: application/json` にします。
- XML の場合は `Content-Type: application/xml` にします。

### 認証

API はほとんどの場合、認証が必要です。API の認証を有効にするには、「管理」→「設定」→「連携」で「RESTによるWebサービスを有効にする」をオンにします。認証には 3 つの方法があります。

- 通常のログインID/パスワードで、HTTP の Basic 認証を使う (Redmine 5.0.0 から、二要素認証を有効にしているユーザーは使えません。代わりに API キーを使います)。
- API キーを使う。スクリプトにパスワードを書かずに済む便利な方法です。API キーは、次のどれかの方法で各リクエストに付けます。
  - パラメーター「key」で渡す
  - HTTP の Basic 認証で、ユーザー名として渡す(パスワードは任意の文字列)
  - HTTP ヘッダー「X-Redmine-API-Key」で渡す(Redmine 1.1.0 で追加)
- 「管理」→「アプリケーション」で登録したアプリケーションに発行された OAuth2 のアクセストークンを使う (ヘッダー `Authorization: Bearer <token>`)。対応しているのは認可コードフローだけです (Redmine 6.1.0 で追加)。

API キーは、ログインして「個人設定」のページ(/my/account)を開くと、デフォルトのレイアウトでは右側の欄に表示されます。

### ユーザーの偽装

Redmine 2.2.0 から、API のリクエストに `X-Redmine-Switch-User` ヘッダーを付けると、REST API でほかのユーザーを偽装できます。値にはユーザーのログインIDを指定します(例: `X-Redmine-Switch-User: jsmith`)。これは管理者のアカウントで API を使う場合だけ働きます。一般のユーザーのアカウントで API を使う場合、このヘッダーは無視されます。

`X-Redmine-Switch-User` ヘッダーで指定したログインIDが存在しないか有効でない場合は、412 のエラーが返ります。

### コレクションのリソースとページ分割

コレクションのリソース(例: `/issues.xml`、`/users.xml`)への GET リクエストは、通常、データベースにあるすべてのオブジェクトを返すわけではありません。Redmine version:1.1.0 で、次のパラメーターでこうしたリソースを取得する共通の方法が導入されました。

- `offset`: 取得する最初のオブジェクトのオフセット
- `limit`: レスポンスに含める件数(デフォルトは 25、最大は 100)
- `page`: 取得するページの番号。指定した limit でオフセットに変換されます。たとえば `page=3&limit=100` は `offset=200&limit=100` と同じです。`offset` と `page` の両方を指定すると、`offset` が優先されます。

例:

```
GET /issues.xml
=> returns the 25 first issues

GET /issues.xml?limit=100
=> returns the 100 first issues

GET /issues.xml?offset=30&limit=10
=> returns 10 issues from the 30th

GET /issues.xml?page=3&limit=10
=> returns 10 issues starting from the 21st issue
```

コレクションのリソースへの GET リクエストのレスポンスには、Redmine にあるオブジェクトの総数と、レスポンスに使った offset/limit の情報が含まれます。例:

```
GET /issues.xml

<issues type="array" total_count="2595" limit="25" offset="0">
  ...
</issues>

GET /issues.json

{ "issues":[...], "total_count":2595, "limit":25, "offset":0 }
```

注: これらの最上位の属性(total_count、limit、offset)に対応していない REST クライアントを使う場合は、パラメーター `nometa` か HTTP ヘッダー `X-Redmine-Nometa` を 1 にすると、これらを含まないレスポンスを受け取れます。例:

```
GET /issues.xml?nometa=1

<issues type="array">
  ...
</issues>
```

### 関連するデータの取得

version:1.1.0 から、取得の結果に含める関連は、URL にパラメーター `include` を付けて明示的に指定する必要があります。

例:

チケットの履歴を説明と一緒に取得するには、次のようにします。

```
GET /issues/296.xml?include=journals

<issue>
  <id>296</id>
  ...
  <journals type="array">
  ...
  </journals>
</issue>
```

カンマ区切りで、複数の関連を読み込むこともできます。

例:

```
GET /issues/296.xml?include=journals,changesets

<issue>
  <id>296</id>
  ...
  <journals type="array">
  ...
  </journals>
  <changesets type="array">
  ...
  </changesets>
</issue>
```

### カスタムフィールドの扱い

Redmine のほとんどのオブジェクトはカスタムフィールドに対応しています。値は `custom_fields` 属性にあります。

XML の例:

```
GET /issues/296.xml      # an issue with 2 custom fields

<issue>
  <id>296</id>
  ...
  <custom_fields type="array">
    <custom_field name="Affected version" id="1">
      <value>1.0.1</value>
    </custom_field>
    <custom_field name="Resolution" id="2">
      <value>Fixed</value>
    </custom_field>
  </custom_fields>
</issue>
```

JSON の例:

```
GET /issues/296.json      # an issue with 2 custom fields

{"issue":
  {
    "id":8471,
    ...
    "custom_fields":
      [
        {"value":"1.0.1","name":"Affected version","id":1},
        {"value":"Fixed","name":"Resolution","id":2}
      ]
  }
}
```

オブジェクトを作成・更新するときも、同じ構文でカスタムフィールドの値を設定・変更できます(カスタムフィールドの名前は不要です)。

XML の例:

```
PUT /issues/296.xml

<issue>
  <subject>Updating custom fields of an issue</subject>
  ...
  <custom_fields type="array">
    <custom_field id="1">
      <value>1.0.2</value>
    </custom_field>
    <custom_field id="2">
      <value>Invalid</value>
    </custom_field>
  </custom_fields>
</issue>
```

注: XML の `custom_fields` タグの `type="array"` 属性は必須です。

JSON の例:

```
PUT /issues/296.json

{"issue":
  {
    "subject":"Updating custom fields of an issue",
    ...
    "custom_fields":
      [
        {"value":"1.0.2","id":1},
        {"value":"Invalid","id":2}
      ]
  }
}
```

### ファイルの添付

REST API による添付ファイルの追加は、Redmine version:1.4.0 で対応しました。

まず、各ファイルを `/uploads.xml`(または `/uploads.json`)への POST リクエストでアップロードします。リクエストの本文は添付するファイルの内容にし、`Content-Type` ヘッダーは `application/octet-stream` にする必要があります(そうしないと `406 Not Acceptable` が返ります)。アップロードに成功すると、アップロードしたファイルのトークンを含む 201 のレスポンスが返ります。

続けて、このトークンを使って、アップロードしたファイルを新しいチケットや既存のチケットに添付します。

注: Redmine version:7.1.0 から、`content_type` 属性は無視されます。代わりに、Redmine がファイルの内容からコンテンツタイプを判定します。Redmine 7.0.3 では、この属性は引き続き使われます。この属性はもともと任意なので、リクエストから削除しても、どのバージョンの Redmine でも問題ありません。

<u>XML の例</u>

まず、ファイルをアップロードします。

```
POST /uploads.xml?filename=image.png
Content-Type: application/octet-stream
...
(request body is the file content)

# 201 response
<upload>
  <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
</upload>
```

続けて、アップロードのトークンを使ってチケットを作成します。

```
POST /issues.xml
<issue>
  <project_id>1</project_id>
  <subject>Creating an issue with a uploaded file</subject>
  <uploads type="array">
    <upload>
      <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
      <filename>image.png</filename>
      <description>An optional description here</description>
      <content_type>image/png</content_type>
    </upload>
  </uploads>
</issue>
```

許可されている最大のサイズを超えるファイルをアップロードしようとすると、422 のレスポンスが返ります。

```
POST /uploads.xml?filename=image.png
Content-Type: application/octet-stream
...
(request body larger than the maximum size allowed)

# 422 response
<errors>
  <error>This file cannot be uploaded because it exceeds the maximum allowed file size (1024000)</error>
</errors>
```

<u>JSON の例</u>

まず、ファイルをアップロードします。

```
POST /uploads.json?filename=image.png
Content-Type: application/octet-stream
...
(request body is the file content)

# 201 response
{"upload":{"token":"7167.ed1ccdb093229ca1bd0b043618d88743"}}
```

続けて、アップロードのトークンを使ってチケットを作成します。

```
POST /issues.json
{
  "issue": {
    "project_id": "1",
    "subject": "Creating an issue with a uploaded file",
    "uploads": [
      {"token": "7167.ed1ccdb093229ca1bd0b043618d88743", "filename": "image.png", "content_type": "image/png"}
    ]
  }
}
```

複数のファイルをアップロードし(`/uploads.json` への POST リクエストを複数回行います)、複数の添付ファイルの付いたチケットを作成することもできます。

```
POST /issues.json
{
  "issue": {
    "project_id": "1",
    "subject": "Creating an issue with a uploaded file",
    "uploads": [
      {"token": "7167.ed1ccdb093229ca1bd0b043618d88743", "filename": "image1.png", "content_type": "image/png"},
      {"token": "7168.d595398bbb104ed3bba0eed666785cc6", "filename": "image2.png", "content_type": "image/png"}
    ]
  }
}
```

### 検証のエラー

属性のパラメーターが不正か不足している状態でオブジェクトを作成・更新しようとすると、`422 Unprocessable Entity` が返ります。これは、オブジェクトを作成・更新できなかったことを表します。この場合、レスポンスの本文に対応するエラーメッセージが入ります。

<u>XML の例</u>:

```
# Request with invalid or missing attributes
POST /users.xml
<user>
  <login>john</login>
  <lastname>Smith</lastname>
  <mail>john</mail>
</uer>

# 422 response with the error messages in its body
<errors type="array">
  <error>First name can't be blank</error>
  <error>Email is invalid</error>
</errors>
```

<u>JSON の例</u>:

```
# Request with invalid or missing attributes
POST /users.json
{
  "user":{
    "login":"john",
    "lastname":"Smith",
    "mail":"john"
  }
}

# 422 response with the error messages in its body
{
  "errors":[
    "First name can't be blank",
    "Email is invalid"
  ]
}
```

### JSONP への対応

Redmine 2.1.0 以降の API は、別のドメインの Redmine のサーバーからデータを取得する(たとえば jQuery で)ための [JSONP](http://en.wikipedia.org/wiki/JSONP) に対応しています。コールバックは、パラメーター `callback` か `jsonp` で渡せます。Redmine 2.3.0 から JSONP への対応は任意で、デフォルトでは無効です。「管理」→「設定」→「連携」で「JSONPを有効にする」をオンにすると有効になります。

例:

```
GET /issues.json?callback=myHandler

myHandler({"issues":[ ... ]})
```

## さまざまな言語・ツールでの API の利用

- [Ruby](rest-api-with-ruby.md)
- [PHP](rest-api-with-php.md)
- [Python](https://www.redmine.org/projects/redmine/wiki/Rest_api_with_python)
- [Perl](rest-api-with-perl.md)
- [Java](rest-api-with-java.md)
- [cURL](rest-api-with-curl.md)
- [Drupal の Redmine API モジュール、2.x ブランチ(現在は不安定)](http://drupal.org/project/redmine)
- [.NET](rest-api-with-csharp.md)
- [Delphi](rest-api-with-delphi.md)

## API の変更履歴

ここでは、既存の API の機能への変更のうち、後方互換性が失われた可能性のあるものを示します。API の新機能は [API の一覧](rest-api.md#API-Description)にあります。

### 2026-08-20: 添付ファイルのコンテンツタイプをファイルの内容から判定(r24959、version:7.1.0)

ファイルのアップロードで、Redmine はクライアントが送るコンテンツタイプを使わなくなりました。ファイルを読み、コンテンツタイプを自分で判定します。次のものは無視されます。

- `uploads` 配列の `content_type` 属性
- `POST /uploads` のクエリパラメーター `content_type`

どちらもエラーにはなりません。値が無視されるだけなので、既存のクライアントはそのまま動きます。変わるのは保存されるコンテンツタイプだけです。

この変更は Redmine 7.0.3 にはありません。Redmine 7.0.3 では、クライアントが送るコンテンツタイプが引き続き使われます。

### 2012-01-29: 複数選択のカスタムフィールド(r8721、version:1.4.0)

Redmine が複数の値を持つカスタムフィールドに対応し、API のレスポンスにも現れるようになりました。これらのカスタムフィールドには `multiple=true` 属性があり、`value` 属性は配列です。

例:

```
GET /issues/296.json

{"issue":
  {
    "id":8471,
    ...
    "custom_fields":
      [
        {"value":["1.0.1","1.0.2"],"multiple":true,"name":"Affected version","id":1},
        {"value":"Fixed","name":"Resolution","id":2}
      ]
  }
}
```
