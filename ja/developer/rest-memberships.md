---
source: Rest_Memberships
translated_from_version: 8
---

# メンバー

## /projects/:project_id/memberships.:format

### GET

プロジェクトのメンバーを、ページ分割した一覧で返します。`:project_id` には、プロジェクトの数値の ID か識別子を指定できます。

<u>例</u>:

```text
GET /projects/1/memberships.xml
GET /projects/redmine/memberships.xml
```

<u>レスポンス</u>:

```text
<?xml version="1.0" encoding="UTF-8"?>
<memberships type="array" limit="25" offset="0" total_count="3">
  <membership>
    <id>1</id>
    <project name="Redmine" id="1"/>
    <user name="David Robert" id="17"/>
    <roles type="array">
      <role name="Manager" id="1"/>
    </roles>
  </membership>
  <membership>
    <id>3</id>
    <project name="Redmine" id="1"/>
    <group name="Contributors" id="24"/>
    <roles type="array">
      <role name="Contributor" id="3"/>
    </roles>
  </membership>
  <membership>
    <id>4</id>
    <project name="Redmine" id="1"/>
    <user name="John Smith" id="27"/>
    <roles type="array">
      <role name="Developer" id="2" />
      <role name="Contributor" id="3" inherited="true" />
    </roles>
  </membership>
</memberships>
```

注:

- メンバーはユーザーかグループのどちらかです ([グループの API](rest-groups.md) は Redmine 2.1 で追加されました)
- 上の例で、最後のロールにある `inherited="true"` 属性は、このロールがグループから継承されたことを表します (たとえば、Jonh Smith が Contributors グループに所属し、このグループがプロジェクトのメンバーに追加されている場合)。John Smith のメンバーは、先にグループのメンバーを削除しないと削除できません。
- 特定のユーザーのメンバーの情報は、[ユーザーの API](rest-users.md) で取得できます。

### POST

プロジェクトにメンバーを追加します。

<u>パラメーター</u>:

- `membership` (必須): メンバーの属性のハッシュ。次のものを含みます:
  - `user_id` (必須): ユーザーまたはグループの数値の ID
  - `role_ids` (必須): ロールの数値の ID の配列

<u>例</u>:

```text
POST /projects/redmine/memberships.xml

<membership>
  <user_id>27</user_id>
  <role_ids type="array">
    <role_id>2</role_id>
  </role_ids>
</membership>
```

JSON

```text
{
  "membership":
  {
    "user_id": 27,
    "role_ids": [ 2 ]
  }
}
```

<u>レスポンス</u>:

- `201 Created`: メンバーを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、メンバーを作成できませんでした (レスポンスの本文にエラーメッセージが入ります)

## /memberships/:id.:format

### GET

指定した `:id` のメンバーを返します。

<u>例</u>:

```text
GET /memberships/1.xml
```

<u>レスポンス</u>:

```text
<?xml version="1.0" encoding="UTF-8"?>
<membership>
  <id>1</id>
  <project name="Redmine" id="1"/>
  <user name="David Robert" id="17"/>
  <roles type="array">
    <role name="Developer" id="2"/>
    <role name="Manager" id="1"/>
  </roles>
</membership>
```

### PUT

指定した :id のメンバーを更新します。更新できるのはロールだけで、メンバーのプロジェクトとユーザーは変更できません。

<u>パラメーター</u>:

- `membership` (必須): メンバーの属性のハッシュ。次のものを含みます:
  - `role_ids` (必須): ロールの数値の ID の配列

<u>例</u>:

```text
PUT /memberships/2.xml

<membership>
  <role_ids type="array">
    <role_id>3</role_id>
    <role_id>4</role_id>
  </role_ids>
</membership>
```

<u>レスポンス</u>:

- `204 No Content`: メンバーを更新しました
- `422 Unprocessable Entity`: 検証に失敗したため、メンバーを更新できませんでした (レスポンスの本文にエラーメッセージが入ります)

### DELETE

メンバーを削除します。

グループのメンバーから継承したメンバーは削除できません。グループのメンバーを削除する必要があります。

<u>パラメーター</u>:

*なし*

<u>例</u>:

```text
DELETE /memberships/2.xml
```

<u>レスポンス</u>:

- `204 No Content`: メンバーを削除しました
- `422 Unprocessable Entity`: メンバーを削除できませんでした
