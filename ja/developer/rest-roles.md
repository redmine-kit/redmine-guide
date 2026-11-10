---
source: Rest_Roles
translated_from_version: 4
---

# ロール

## /roles.:format

### GET

ロールの一覧を返します。

<u>例</u>:

```text
GET /roles.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<roles type="array">
  <role>
    <id>1</id>
    <name>Manager</name>
  </role>
  <role>
    <id>2</id>
    <name>Developer</name>
  </role>
</roles>
```

## /roles/\[id\].:format

### GET

指定したロールの権限の一覧を返します([2.2.0](https://www.redmine.org/versions/56))。

<u>例</u>:

```text
GET /roles/5.xml
```

<u>レスポンス</u>:

```xml
<role>
  <id>5</id>
  <name>Reporter</name>
  <assignable>true</assignable>
  <issues_visibility>default</issues_visibility>
  <time_entries_visibility>all</time_entries_visibility>
  <users_visibility>all</users_visibility>
  <permissions type="array">
    <permission>view_issues</permission>
    <permission>add_issues</permission>
    <permission>add_issue_notes</permission>
    ...
  </permissions>
</role>
```
