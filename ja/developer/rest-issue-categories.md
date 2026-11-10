---
source: Rest_IssueCategories
translated_from_version: 4
---

# チケットのカテゴリ

## /projects/:project_id/issue_categories.:format

### GET

指定した ID または識別子(:project_id)のプロジェクトで使えるチケットのカテゴリを返します。

<u>例</u>:

```
GET /projects/foo/issue_categories.xml
GET /projects/1/issue_categories.xml
```

<u>レスポンス</u>:

```
<?xml version="1.0" encoding="UTF-8"?>
<issue_categories type="array" total_count="2">
  <issue_category>
    <id>57</id>
    <project name="Foo" id="17"/>
    <name>UI</name>
    <assigned_to name="John Smith" id="22"/>
  </issue_category>
  <issue_category>
    <id>58</id>
    <project name="Foo" id="17"/>
    <name>Test</name>
  </issue_category>
</issue_categories>
```

### POST

指定した ID または識別子(:project_id)のプロジェクトに、チケットのカテゴリを作成します。

<u>パラメーター</u>:

- `issue_category`(必須): チケットのカテゴリの属性のハッシュ。次のものを含みます:
  - `name`(必須)
  - `assigned_to_id`: カテゴリの担当者のユーザーの ID(このカテゴリの新しいチケットは、デフォルトでこのユーザーに割り当てられます)

<u>レスポンス</u>:

- `201 Created`: チケットのカテゴリを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、チケットのカテゴリを作成できませんでした(レスポンスの本文にエラーメッセージが入ります)

## /issue_categories/:id.:format

### GET

指定した ID のチケットのカテゴリを返します。

<u>例</u>:

```
GET /issue_categories/2.xml
```

<u>レスポンス</u>:

```
<?xml version="1.0" encoding="UTF-8"?>
<issue_category>
  <id>2</id>
  <project name="Redmine" id="1"/>
  <name>UI</name>
</version>
```

### PUT

指定した ID のチケットのカテゴリを更新します。

<u>パラメーター</u>:

チケットのカテゴリの作成と同じです。

<u>レスポンス</u>:

- `204 No Content`: チケットのカテゴリを更新しました
- `422 Unprocessable Entity`: 検証に失敗したため、チケットのカテゴリを更新できませんでした(レスポンスの本文にエラーメッセージが入ります)

### DELETE

指定した ID のチケットのカテゴリを削除します。

<u>パラメーター</u>:

- `reassign_to_id`(任意): 削除するカテゴリが設定されたチケットがある場合に、それらのチケットをこの ID のカテゴリに付け替えます

<u>例</u>:

```
DELETE /issue_categories/2.xml
DELETE /issue_categories/2.xml?reassign_to_id=1
```

<u>レスポンス</u>:

- `204 No Content`: チケットのカテゴリを削除しました
