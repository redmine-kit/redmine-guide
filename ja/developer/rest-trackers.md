---
source: Rest_Trackers
translated_from_version: 3
---

# トラッカー

## /trackers.:format

### GET

すべてのトラッカーの一覧を返します。

<u>例</u>:

```
GET /trackers.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<trackers type="array">
  <tracker>
    <id>1</id>
    <name>Defect</name>
    <default_status id="1" name="New"/>
    <description>Description for Bug tracker</description>
    <enabled_standard_fields type="array">
      <field>assigned_to_id</field>
      <field>category_id</field>
      <field>fixed_version_id</field>
      <field>parent_issue_id</field>
      <field>start_date</field>
      <field>due_date</field>
      <field>estimated_hours</field>
      <field>done_ratio</field>
      <field>description</field>
    </enabled_standard_fields>
  </tracker>
  <tracker>
    <id>2</id>
    <name>Feature</name>
    <default_status id="1" name="New"/>
    <description>Description for Feature request tracker</description>
    <enabled_standard_fields type="array">
      <field>assigned_to_id</field>
      <field>category_id</field>
      <field>fixed_version_id</field>
      <field>parent_issue_id</field>
      <field>start_date</field>
      <field>due_date</field>
      <field>estimated_hours</field>
      <field>done_ratio</field>
      <field>description</field>
    </enabled_standard_fields>
  </tracker>
</trackers>
```

- `description`: Redmine 4.2.0 から利用できます
- `enabled_standard_fields`: Redmine 5.0.0 から利用できます
