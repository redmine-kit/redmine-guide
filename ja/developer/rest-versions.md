---
source: Rest_Versions
translated_from_version: 11
---

# バージョン

## /projects/:project_id/versions.:format

### GET

指定した ID または識別子 (:project_id) のプロジェクトで使えるバージョンを返します。レスポンスには、ほかのプロジェクトから共有されたバージョンが含まれることがあります。

<u>例</u>:

```text
GET /projects/foo/versions.xml
GET /projects/1/versions.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<versions type="array" total_count="34">
  <version>
    <id>1</id>
    <project name="Redmine" id="1"/>
    <name>0.7</name>
    <description/>
    <status>closed</status>
    <due_date>2008-04-28</due_date>
    <sharing>none</sharing>
    <created_on>2008-03-09T12:52:06+01:00</created_on>
    <updated_on>2009-11-15T12:22:12+01:00</updated_on>
    <wiki_page_title>FooBarWikiPage</version_wiki_page_title>
  </version>
  <version>
    <id>2</id>
    <project name="Redmine" id="1"/>
    <name>0.8</name>
    <description/>
    <status>closed</status>
    <due_date>2008-12-30</due_date>
    <sharing>none</sharing>
    <wiki_page_title>FooBarWikiPage</version_wiki_page_title>
    <created_on>2008-03-09T12:52:12+01:00</created_on>
    <updated_on>2009-11-15T12:22:12+01:00</updated_on>
  </version>
</versions>
```

### POST

指定した ID または識別子 (:project_id) のプロジェクトにバージョンを作成します。

<u>パラメーター</u>:

- `version` (必須): バージョンの属性のハッシュ。次のものを含みます:
  - `name` (必須)
  - `status`: バージョンのステータス。`open (default), locked, closed` のどれか
  - `sharing`: バージョンの共有。`none (default), descendants, hierarchy, tree, system` のどれか
  - `due_date`
  - `description`
  - `wiki_page_title`

<u>レスポンス</u>:

- `201 Created`: バージョンを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、バージョンを作成できませんでした (レスポンスの本文にエラーメッセージが入ります)

## /versions/:id.:format

### GET

指定した ID のバージョンを返します。

<u>例</u>:

```text
GET /versions/2.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<version>
  <id>2</id>
  <project name="Redmine" id="1"/>
  <name>0.8</name>
  <description/>
  <status>closed</status>
  <due_date>2008-12-30</due_date>
  <estimated_hours>0.0</estimated_hours>
  <spent_hours>0.0</spent_hours>
  <created_on>2008-03-09T12:52:12+01:00</created_on>
  <updated_on>2009-11-15T12:22:12+01:00</updated_on>
</version>
```

### PUT

指定した ID のバージョンを更新します。

<u>パラメーター</u>:

バージョンの作成と同じです。

<u>レスポンス</u>:

- `204 No Content`: バージョンを更新しました
- `422 Unprocessable Entity`: 検証に失敗したため、バージョンを更新できませんでした (レスポンスの本文にエラーメッセージが入ります)

### DELETE

指定した ID のバージョンを削除します。

<u>レスポンス</u>:

- `204 No Content`: バージョンを削除しました
- `422 Unprocessable Entity`: バージョンを削除できませんでした (レスポンスの本文にエラーメッセージが入ります)
