---
source: Rest_IssueCategories
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_IssueCategories
source_version: 4
source_updated_on: '2021-09-08T23:36:47Z'
---

# Issue Categories

## /projects/:project_id/issue_categories.:format

### GET

Returns the issue categories available for the project of given id or identifier (:project_id).

<u>Examples</u>:

```text
GET /projects/foo/issue_categories.xml
GET /projects/1/issue_categories.xml
```

<u>Response</u>:

```text
<?xml version="1.0" encoding="UTF-8"?>
<issue_categories type="array" total_count="2">
  <issue_category>
    <id>57</id>
    <project name="Foo" id="17"/>
    <name>UI</name>
    <assigned_to name="John Smith" id="22"/>
  </issue_category>
  <issue_category>
    <id>58</id>
    <project name="Foo" id="17"/>
    <name>Test</name>
  </issue_category>
</issue_categories>
```

### POST

Creates an issue category for the project of given id or identifier (:project_id).

<u>Parameters</u>:

- `issue_category` (required): a hash of the issue category attributes, including:
  - `name` (required)
  - `assigned_to_id`: the id of the user assigned to the category (new issues with this category are assigned by default to this user)

<u>Response</u>:

- `201 Created`: issue category was created
- `422 Unprocessable Entity`: issue category was not created due to validation failures (response body contains the error messages)

## /issue_categories/:id.:format

### GET

Returns the issue category of given id.

<u>Example</u>:

```text
GET /issue_categories/2.xml
```

<u>Response</u>:

```text
<?xml version="1.0" encoding="UTF-8"?>
<issue_category>
  <id>2</id>
  <project name="Redmine" id="1"/>
  <name>UI</name>
</version>
```

### PUT

Updates the issue category of given id

<u>Parameters</u>:

Same as issue category creation

<u>Response</u>:

- `204 No Content`: issue category was updated
- `422 Unprocessable Entity`: issue category was not updated due to validation failures (response body contains the error messages)

### DELETE

Deletes the issue category of given id.

<u>Parameters</u>:

- `reassign_to_id` (optional): when there are issues assigned to the category you are deleting, this parameter lets you reassign these issues to the category with this id

<u>Example</u>:

```text
DELETE /issue_categories/2.xml
DELETE /issue_categories/2.xml?reassign_to_id=1
```

<u>Response</u>:

- `204 No Content`: issue category was deleted
