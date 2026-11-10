---
source: Rest_Groups
translated_from_version: 10
---

# グループ

## /groups.:format

### GET

グループの一覧を返します。

このエンドポイントには管理者の権限が必要です。

<u>例</u>:

GET /groups.xml

<u>レスポンス</u>:

```text
<groups type="array">
  <group>
    <id>53</id>
    <name>Managers</name>
  </group>
  <group>
    <id>55</id>
    <name>Developers</name>
  </group>
</groups>
```

### POST

グループを作成します。

このエンドポイントには管理者の権限が必要です。

<u>パラメーター</u>:

- `group` (必須): グループの属性のハッシュ。次のものを含みます:
  - `name` (必須): グループの名前
  - `user_ids`: グループのユーザーの ID (指定しない場合は空のグループを作成します)

<u>例</u>:

```text
POST /groups.xml

<group>
  <name>Developers</name>
  <user_ids type="array">
    <user_id>3</user_id>
    <user_id>5</user_id>
  </user_ids>
</group>
```

```text
POST /groups.json

{
  "group": {
    "name": "Developers",
    "user_ids": [ 3, 5 ]
  }
}
```

<u>レスポンス</u>:

- `201 Created`: グループを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、グループを作成できませんでした (レスポンスの本文にエラーメッセージが入ります)

## /groups/:id.:format

### GET

グループの詳細を返します。

このエンドポイントには管理者の権限が必要です。

<u>パラメーター</u>:

- `include` (任意): レスポンスに含める関連の、カンマ区切りの一覧:
  - `users`
  - `memberships`

<u>例</u>:

GET /groups/20.xml?include=users

<u>レスポンス</u>:

```text
<group>
  <id>20</id>
  <name>Developers</name>
  <users type="array">
    <user id="5" name="John Smith"/>
    <user id="8" name="Dave Loper"/>
  </users>
</group>
```

### PUT

既存のグループを更新します。

このエンドポイントには管理者の権限が必要です。

### DELETE

既存のグループを削除します。

このエンドポイントには管理者の権限が必要です。

## /groups/:id/users.:format

### POST

既存のユーザーをグループに追加します。

このエンドポイントには管理者の権限が必要です。

<u>パラメーター</u>:

- `user_id` または `user_ids` (必須): グループに追加するユーザーの ID (または、ユーザーの ID の配列)。

<u>例</u>:

```text
POST /groups/10/users.xml

<user_id>5</user_id>
```

<u>レスポンス</u>:

- `204 No Content`: ユーザーをグループに追加しました

## /groups/:id/users/:user_id.:format

### DELETE

ユーザーをグループから外します。このエンドポイントは非推奨で、Redmine 8.0 で削除される予定です。代わりに、パラメーター `user_ids` (ユーザーの ID の配列) を指定して `DELETE /groups/:id/users.:format` を使います。

このエンドポイントには管理者の権限が必要です。

<u>例</u>:

```text
DELETE /groups/10/users/5.xml
```

<u>レスポンス</u>:

- `204 No Content`: ユーザーをグループから外しました
