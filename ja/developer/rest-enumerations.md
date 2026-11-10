---
source: Rest_Enumerations
translated_from_version: 3
---

# 選択肢の値

## /enumerations/issue_priorities.:format

### GET

[チケット](rest-issues.md)の優先度の一覧を返します。

<u>例</u>:

```
GET /enumerations/issue_priorities.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<issue_priorities type="array">
  <issue_priority>
    <id>3</id>
    <name>Low</name>
    <is_default>false</is_default>
  </issue_priority>
  <issue_priority>
    <id>4</id>
    <name>Normal</name>
    <is_default>true</is_default>
  </issue_priority>
  ...
</issue_priorities>
```

## /enumerations/time_entry_activities.:format

### GET

[作業時間](rest-time-entries.md)の作業分類の一覧を返します。

<u>例</u>:

```
GET /enumerations/time_entry_activities.xml
```

<u>レスポンス</u>:

```xml
<time_entry_activities type="array">
  <time_entry_activity>
    <id>8</id>
    <name>Design</name>
    <is_default>false</is_default>
  </time_entry_activity>
  ...
</time_entry_activities>
```

## /enumerations/document_categories.:format

### GET

文書のカテゴリの一覧を返します。

<u>例</u>:

```
GET /enumerations/document_categories.xml
```

<u>レスポンス</u>:

```xml
<document_categories type="array">
  <document_category>
    <id>1</id>
    <name>Uncategorized</name>
    <is_default>false</is_default>
  </document_category>
  <document_category>
    <id>2</id>
    <name>User documentation</name>
    <is_default>false</is_default>
  </document_category>
  <document_category>
    <id>3</id>
    <name>Technical documentation</name>
    <is_default>false</is_default>
  </document_category>
</document_categories>
```
