---
source: Rest_Roles
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Roles
source_version: 4
source_updated_on: '2018-12-12T06:17:18Z'
---

# Roles

## /roles.:format

### GET

Returns the list of roles.

<u>Examples</u>:

    GET /roles.xml

<u>Response</u>:

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

Returns the list of permissions for a given role (version:2.2.0).

<u>Examples</u>:

    GET /roles/5.xml

<u>Response</u>:

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
