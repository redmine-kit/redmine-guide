---
source: Rest_CustomFields
translated_from_version: 3
---

# カスタムフィールド

## /custom_fields.:format

### GET

すべてのカスタムフィールドの定義を返します。

このエンドポイントには管理者の権限が必要です。

<u>例</u>:

```text
GET /custom_fields.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<custom_fields type="array">
  <custom_field>
    <id>1</id>
    <name>Affected version</name>
    <customized_type>issue</customized_type>
    <field_format>list</field_format>
    <regexp/>
    <min_length/>
    <max_length/>
    <is_required>true</is_required>
    <is_filter>true</is_filter>
    <searchable>true</searchable>
    <multiple>true</multiple>
    <default_value/>
    <visible>false</visible>
    <possible_values type="array">
      <possible_value>
        <value>0.5.x</value>
      </possible_value>
      <possible_value>
        <value>0.6.x</value>
      </possible_value>
  <custom_field>
  <custom_field>
    ...
  </custom_field>
</custom_fields>
```

`customized_type` 属性は、カスタムフィールドを適用するオブジェクトの種類(issue、project、time_entry など)を表します。
