---
source: Rest_Journals
translated_from_version: 1
---

# 履歴

## チケットの履歴の表示

GET /issues/\[issue_id\].\[format\]?include=journals

チケットの履歴を返します。パラメーター `include` に `journals` を指定すると、チケットのレスポンスに履歴が含まれます。

<u>例</u>:

```
GET /issues/1.xml?include=journals
GET /issues/1.json?include=journals
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<issue>
  <id>1</id>
  <project id="1" name="eCookbook"/>
  <tracker id="1" name="Bug"/>
  <status id="1" name="New" is_closed="false"/>
  <priority id="4" name="Low"/>
  <author id="2" name="John Smith"/>
  <category id="1" name="Printing"/>
  <subject>Cannot print recipes</subject>
  <description>Unable to print recipes</description>
  <start_date>2026-06-03</start_date>
  <due_date>2026-06-14</due_date>
  <done_ratio>0</done_ratio>
  <is_private>false</is_private>
  <created_on>2026-06-01T08:22:41Z</created_on>
  <updated_on>2026-06-03T08:22:41Z</updated_on>
  <closed_on/>
  <journals type="array">
    <journal id="1">
      <user id="1" name="Redmine Admin"/>
      <notes>Journal notes</notes>
      <created_on>2026-06-01T15:00:00Z</created_on>
      <updated_on>2026-06-02T15:00:00Z</updated_on>
      <updated_by id="1" name="Redmine Admin"/>
      <private_notes>false</private_notes>
      <details type="array">
        <detail property="attr" name="status_id">
          <old_value>1</old_value>
          <new_value>2</new_value>
        </detail>
        <detail property="attr" name="done_ratio">
          <old_value>40</old_value>
          <new_value>30</new_value>
        </detail>
      </details>
    </journal>
    <journal id="2">
      <user id="2" name="John Smith"/>
      <notes>Some notes with Redmine links: #2, r2.</notes>
      <created_on>2026-06-02T15:00:00Z</created_on>
      <updated_on>2026-06-02T15:00:00Z</updated_on>
      <private_notes>false</private_notes>
      <details type="array"></details>
    </journal>
  </journals>
</issue>
```

## 履歴の更新

PUT /journals/\[id\].\[format\]

履歴のコメントを更新します。ユーザーには、履歴のコメントを編集する権限が必要です。

<u>パラメーター</u>:

- `journal` - 履歴の属性のハッシュ:
  - `notes`
  - `private_notes`: 履歴をプライベートにします(任意。コメントをプライベートにする権限が必要です)

<u>例</u>:

```
PUT /journals/1.xml

<code class="xml">
<?xml version="1.0"?>
<journal>
  <notes>Changed notes</notes>
</journal>
</code>

PUT /journals/1.json

<code class="json">
{
  "journal": {
    "notes": "Changed notes"
  }
}
</code>
```

`private_notes` 属性は、コメントをプライベートにする権限を持つユーザーが更新できます。

```
PUT /journals/1.json

<code class="json">
{
  "journal": {
    "private_notes": true
  }
}
</code>
```

<u>レスポンス</u>:

`204 No Content`

## 履歴の削除

履歴は `DELETE` メソッドでは削除できません。履歴を削除するには、`notes` を空の値にして更新します。

PUT /journals/\[id\].\[format\]

履歴に変更の詳細がなく、`notes` を空の値にすると、履歴は削除されます。

<u>例</u>:

```
PUT /journals/1.xml

<code class="xml">
<?xml version="1.0"?>
<journal>
  <notes></notes>
</journal>
</code>

PUT /journals/1.json

<code class="json">
{
  "journal": {
    "notes": ""
  }
}
</code>
```

<u>レスポンス</u>:

`204 No Content`
