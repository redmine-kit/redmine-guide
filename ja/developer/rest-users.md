---
source: Rest_Users
translated_from_version: 30
---

# ユーザー

## /users.:format

### GET

ユーザーの一覧を返します。

このエンドポイントには管理者の権限が必要です。

<u>例</u>:

GET /users.xml

任意のフィルター:

- `status`: 指定したステータスのユーザーだけを取得します。使えるステータスの一覧は [app/models/principal.rb](https://www.redmine.org/projects/redmine/repository/entry/trunk/app/models/principal.rb#L22-25) を参照してください。`*` を指定すると、ステータスにかかわらずすべてのユーザーが対象になります (`1|3` のように、`|` で区切って複数のステータスも指定できます)。デフォルトは `1` (有効なユーザー) です。指定できる値:
  - `1`: 「有効」(ユーザーはログインしてアカウントを使えます)
  - `2`: 「登録」(ユーザーは登録したが、まだメールアドレスを確認していないか、管理者が有効にしていません。ユーザーはログインできません)
  - `3`: 「ロック中」(ユーザーは一度有効になった後、ロックされています。ユーザーはログインできません)
- `name`: ログインID、名、姓、メールアドレスでユーザーを絞り込みます。パターンに空白が含まれる場合は、名が最初の語に一致するか、姓が 2 番目の語に一致するユーザーも返します。
- `group_id`: 指定したグループのメンバーのユーザーだけを取得します

### POST

ユーザーを作成します。

このエンドポイントには管理者の権限が必要です。

<u>パラメーター</u>:

- `user` (必須): ユーザーの属性のハッシュ。次のものを含みます:
  - `login` (必須): ユーザーのログインID
  - `password`: ユーザーのパスワード
  - `firstname` (必須)
  - `lastname` (必須)
  - `mail` (必須)
  - `auth_source_id`: 認証方式の ID
  - `mail_notification`: only_my_events、none など
  - `must_change_passwd`: true または false
  - `generate_password`: true または false
  - `custom_fields` - [カスタムフィールドの扱い](rest-api.md#Working-with-custom-fields)を参照

- `send_information`: true または false。ユーザーにアカウントの情報を送信します

<u>例</u>:

```text
POST /users.xml
```

```xml
<?xml version="1.0" encoding="ISO-8859-1" ?>
<user>
  <login>jplang</login>
  <firstname>Jean-Philippe</firstname>
  <lastname>Lang</lastname>
  <password>secret</password>
  <mail>jp_lang@yahoo.fr</mail>
  <auth_source_id>2</auth_source_id>
</user>
```

JSON

```json
{
    "user": {
        "login": "jplang",
        "firstname": "Jean-Philippe",
        "lastname": "Lang",
        "mail": "jp_lang@yahoo.fr",
        "password": "secret"
    }
}
```

<u>レスポンス</u>:

- `201 Created`: ユーザーを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、ユーザーを作成できませんでした (レスポンスの本文にエラーメッセージが入ります)

## /users/:id.:format

### GET

ユーザーの詳細を返します。API へのアクセスに認証情報を使っているユーザーは、`/users/current.:format` で取得できます。

このエンドポイントは管理者も管理者以外も使えますが、返すフィールドはリクエストしたユーザーの権限によって変わります (下のレスポンスを参照)。

<u>パラメーター</u>:

- `include` (任意): レスポンスに含める関連の、カンマ区切りの一覧:
  - `memberships`: ユーザーがメンバーになっているプロジェクトと、そのロールの情報を追加します
  - `groups` (2.1 で追加): ユーザーのグループの情報を追加します

<u>例</u>:

GET /users/current.xml

現在のユーザーの詳細を返します。

GET /users/3.xml?include=memberships,groups

ID が 3 のユーザーの詳細と、そのユーザーのプロジェクトのメンバーの詳細を返します。

<u>レスポンス</u>:

```xml
<user>
  <id>3</id>
  <login>jplang</login>
  <firstname>Jean-Philippe</firstname>
  <lastname>Lang</lastname>
  <mail>jp_lang@yahoo.fr</mail>
  <created_on>2007-09-28T00:16:04+02:00</created_on>
  <updated_on>2010-08-01T18:05:45+02:00</updated_on>
  <last_login_on>2011-08-01T18:05:45+02:00</last_login_on>
  <passwd_changed_on>2011-08-01T18:05:45+02:00</passwd_changed_on>
  <api_key>ebc3f6b781a6fb3f2b0a83ce0ebb80e0d585189d</api_key>
  <avatar_url></avatar_url>
  <status>1</status>
  <custom_fields type="array" />
  <memberships type="array">
    <membership>
      <project name="Redmine" id="1"/>
      <roles type="array">
        <role name="Administrator" id="3"/>
        <role name="Contributor" id="4"/>
      </roles>
    </membership>
  </memberships>
  <groups type="array">
    <group id="20" name="Developers"/>
  </groups>
</user>
```

リクエストしたユーザーが管理者でない場合は、対象のユーザーによって次のように変わります。

- ユーザーが表示可能で、ロックされていない場合は、フィールド `login`、`firstname`、`lastname`、`mail` (そのユーザーが個人設定で「メールアドレスを隠す」をオンにしている場合を除く)、`created_on`、`updated_on`、`last_login_on`、`passwd_changed_on`、`avatar_url` (Gravatar が有効な場合) を持つユーザーのオブジェクトを返します
- ユーザーがロックされている場合は、ステータスコード 404 を返します
- ユーザーがリクエストしたユーザー本人の場合は、フィールド `admin`、`twofa_scheme`、`api_key` も返します (OAuth で認証した場合、`api_key` は返しません)

リクエストしたユーザーが管理者の場合は、(ロックされているかどうかにかかわらず) 常にユーザーのオブジェクトを返します。さらに次の詳細が含まれます。

- `api_key`: ユーザーの API キー。管理者と本人に見えます (2.3.0 で追加)
- `status`: ユーザーのステータスを表す数値の ID。管理者だけに見えます (2.4.0 で追加)。使えるステータスの一覧は [app/models/principal.rb](https://www.redmine.org/projects/redmine/repository/entry/trunk/app/models/principal.rb#L22-25) を参照してください。

### PUT

ユーザーを更新します。

このエンドポイントには管理者の権限が必要です。

<u>例</u>:

PUT /users/20.xml

<u>パラメーター</u>:

- `user` (必須): ユーザーの属性のハッシュ (ユーザーの作成と同じ)
- `admin` (任意): *true* または *false*。ユーザーにこの Redmine の管理者の権限を与えます
- `custom_fields` - [カスタムフィールドの扱い](rest-api.md#Working-with-custom-fields)を参照

### DELETE

このエンドポイントには管理者の権限が必要です。

ユーザーを削除します。

<u>例</u>:

DELETE /users/20.xml

<u>レスポンス</u>:

- `204 No Content`: ユーザーを削除しました

## 関連情報

- ユーザーをプロジェクトに追加・削除するには、[メンバーの API](rest-memberships.md)。
- ユーザーをグループに追加・削除するには、[グループの API](rest-groups.md)。
