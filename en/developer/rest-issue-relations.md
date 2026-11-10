---
source: Rest_IssueRelations
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_IssueRelations
source_version: 10
source_updated_on: '2021-09-09T13:22:22Z'
---

# Issue Relations

## /issues/:issue_id/relations.:format

### GET

Returns the relations for the issue of given id (:issue_id).

<u>XML example</u>:

```text
GET /issues/8470/relations.xml
```

<u>Response</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relations type="array">
  <relation>
    <id>1819</id>
    <issue_id>8470</issue_id>
    <issue_to_id>8469</issue_to_id>
    <relation_type>relates</relation_type>
    <delay/>
  </relation>
  <relation>
    <id>1820</id>
    <issue_id>8470</issue_id>
    <issue_to_id>8467</issue_to_id>
    <relation_type>relates</relation_type>
    <delay/>
  </relation>
</relations>
```

<u>json example</u>:

```text
GET /issues/8470/relations.json
```

<u>Response</u>:

```json
{
    "relations": [
        {
            "delay": null,
            "id": 1819,
            "issue_id": 8470,
            "issue_to_id": 8469,
            "relation_type": "relates"
        },
        {
            "delay": null,
            "id": 1820,
            "issue_id": 8470,
            "issue_to_id": 8467,
            "relation_type": "relates"
        }
    ]
}
```

Note: when getting an issue, relations can also be retrieved in a single request using `/issues/:id.:format?include=relations`.

### POST

Creates a relation for the issue of given id (:issue_id).

<u>Parameters</u>:

- `relation` (required): a hash of the relation attributes, including:
  - `issue_to_id` (required): the id of the related issue
  - `relation_type` (required to explicit : default “relates”): the type of relation (in: “relates”, “duplicates”, “duplicated”, “blocks”, “blocked”, “precedes”, “follows”, “copied_to”, “copied_from”)
  - `delay` (optional): the delay for a “precedes” or “follows” relation

<u>Response</u>:

- `201 Created`: relation was created
- `422 Unprocessable Entity`: relation was not created due to validation failures (response body contains the error messages)

<u>Examples</u>:

```text
POST /issues/83/relations.xml
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relation>
  <issue_to_id>82</issue_to_id>
  <relation_type>relates</relation_type>
</relation>
```

```text
POST /issues/83/relations.json
```

```json
{
  "relation": {
    "issue_to_id": 82,
    "relation_type": "relates"
  }
}
```

## /relations/:id.:format

### GET

Returns the relation of given id.

<u>XML example</u>:

```text
GET /relations/1819.xml
```

<u>Response</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relation>
  <id>1819</id>
  <issue_id>8470</issue_id>
  <issue_to_id>8469</issue_to_id>
  <relation_type>relates</relation_type>
  <delay/>
</relation>
```

<u>json example</u>:

```text
GET /relations/1819.json
```

<u>Response</u>:

```json
{
    "relation": {
        "delay": null,
        "id": 1819,
        "issue_id": 8470,
        "issue_to_id": 8469,
        "relation_type": "relates"
    }
}
```

### DELETE

Deletes the relation of given id.

<u>Response</u>:

- `204 No Content`: relation was deleted
- `422 Unprocessable Entity`: relation was not deleted (response body contains the error messages)
