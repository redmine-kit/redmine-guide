---
source: Rest_Journals
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Journals
source_version: 1
source_updated_on: '2026-06-06T09:22:55Z'
---

# Journals

## Showing journals for an issue

GET /issues/\[issue_id\].\[format\]?include=journals

Returns the journals for an issue. Journals are included in the issue response when `journals` is specified in the `include` parameter.

<u>Examples</u>:

    GET /issues/1.xml?include=journals
    GET /issues/1.json?include=journals

<u>Response</u>:

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

## Updating a journal

PUT /journals/\[id\].\[format\]

Updates the notes of a journal. The user must have permission to edit the journal notes.

<u>Parameters</u>:

- `journal` - A hash of the journal attributes:
  - `notes`
  - `private_notes`: set the journal as private (optional, requires permission to set notes as private)

<u>Examples</u>:

    PUT /journals/1.xml

```xml
<?xml version="1.0"?>
<journal>
  <notes>Changed notes</notes>
</journal>
```

    PUT /journals/1.json

```json
{
  "journal": {
    "notes": "Changed notes"
  }
}
```

The `private_notes` attribute can be updated by users who have permission to set notes as private:

    PUT /journals/1.json

```json
{
  "journal": {
    "private_notes": true
  }
}
```

<u>Response</u>:

`204 No Content`

## Deleting a journal

Journals cannot be deleted with the `DELETE` method. To delete a journal, update it with an empty `notes` value.

PUT /journals/\[id\].\[format\]

If the journal has no details and `notes` is set to an empty value, the journal is deleted.

<u>Examples</u>:

    PUT /journals/1.xml

```xml
<?xml version="1.0"?>
<journal>
  <notes></notes>
</journal>
```

    PUT /journals/1.json

```json
{
  "journal": {
    "notes": ""
  }
}
```

<u>Response</u>:

`204 No Content`
