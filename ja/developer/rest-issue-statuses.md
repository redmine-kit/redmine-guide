---
source: Rest_IssueStatuses
translated_from_version: 3
---

# チケットのステータス

## /issue_statuses.:format

### GET

すべてのチケットのステータスの一覧を返します。

<u>例</u>:

```
GET /issue_statuses.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<issue_statuses type="array">
  <issue_status>
    <id>1</id>
    <name>New</name>
    <is_closed>false</is_closed>
  </issue_status>
  <issue_status>
    <id>2</id>
    <name>Closed</name>
    <is_closed>true</is_closed>
  </issue_status>
</issue_statuses>
```
