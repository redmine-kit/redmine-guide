---
source: Rest_TimeEntries
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_TimeEntries
source_version: 15
source_updated_on: '2021-09-09T13:19:49Z'
updated_for: 7.0.3
---

# Rest TimeEntries

(note: for some versions of Redmine you can need some other extension of path /time_entries.xml, e.g. 2.5 works with \*.json http://www.redmine.org/boards/2/topics/48933?r=48934#message-48934 , sometimes in plugins it comes simply without any extension)

# Time Entries

## Listing time entries

GET /time_entries.xml

Returns time entries.

<u>Parameters</u>:

- `offset`
- `limit`
- `user_id`
- `project_id`
- `spent_on`
- …

### `project_id` filter

When filtering by project id, you can use either project numeric ID or its string identifier, e.g.

```text
...&project_id=123
```

```text
...&project_id=my-custom-project
```

### `spent_on` filter

When filtering by date, you can require a min / max date with a custom syntax:

```text
/time_entries.json?project_id=338&from=2019-01-01&to=2019-01-03&limit=100
```

## Showing a time entry

GET /time_entries/\[id\].xml

Returns the time entry of given id.

## Creating a time entry

POST /time_entries.xml

Creates a time entry.

<u>Parameters</u>:

- `time_entry` (required): a hash of the time entry attributes, including:
  - `issue_id` or `project_id` (only one is required): the issue id or project id to log time on (both are integers); note that project ids can only be found using the API (e.g. at /projects.json)
  - `spent_on`: the date the time was spent (default to the current date); format is e.g. `2020-12-24`
  - `hours` (required): the number of spent hours
  - `activity_id`: the id of the time activity. This parameter is required unless a default activity is defined in Redmine.
  - `comments`: short description for the entry (1024 characters max)
  - `user_id`: user id to be specified in need of posting time on behalf of another user

<u>Response</u>:

- `201 Created`: time entry was created
- `422 Unprocessable Entity`: time entry was not created due to validation failures (response body contains the error messages)

## Updating a time entry

PUT /time_entries/\[id\].xml

Updates the time entry of given id.

<u>Parameters</u>:

- `time_entry` (required): a hash of the time entry attributes (same as above)

<u>Response</u>:

- `204 No Content`: time entry was updated
- `422 Unprocessable Entity`: time entry was not updated due to validation failures (response body contains the error messages)

## Deleting a time entry

DELETE /time_entries/\[id\].xml

Deletes the time entry of given id.
