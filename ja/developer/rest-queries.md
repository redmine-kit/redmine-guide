---
source: Rest_Queries
translated_from_version: 3
---

# カスタムクエリ

## /queries.:format

### GET

すべてのプロジェクトについて、ユーザーから見えるすべてのカスタムクエリ(公開と非公開)の一覧を返します。

<u>例</u>:

```text
GET /queries.xml
```

<u>レスポンス</u>:

```text
<?xml version="1.0" encoding="UTF-8"?>
<queries type="array" total_count="5" limit="25" offset="0">
  <query>
    <id>84</id>
    <name>Documentation issues</name>
    <is_public>true</is_public>
    <project_id>1</project_id>
  </query>
  <query>
    <id>1</id>
    <name>Open defects</name>
    <is_public>true</is_public>
    <project_id>1</project_id>
  </query>
</queries>
```

クエリの ID がわかれば、次のようにして対応するチケットの一覧を取得できます。

```text
GET /issues.xml?query_id=:id
GET /issues.xml?query_id=:id&project_id=foo
```
