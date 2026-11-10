---
source: Rest_IssueStatuses
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_IssueStatuses
source_version: 3
source_updated_on: '2021-07-23T02:44:48Z'
---

# Issue Statuses

## /issue_statuses.:format

### GET

Returns the list of all issue statuses.

<u>Examples</u>:

```text
GET /issue_statuses.xml
```

<u>Response</u>:

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
