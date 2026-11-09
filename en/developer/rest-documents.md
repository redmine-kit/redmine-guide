---
source: Rest_Documents
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Documents
source_version: 1
source_updated_on: '2026-09-16T09:09:33Z'
---

# Rest Documents

## Listing documents

    GET /projects/[project_id]/documents.[format]

Returns a paginated list of documents for the project with the given id or identifier.

Parameters:

- `offset`: skip this number of documents in the response (optional)
- `limit`: number of documents per page (optional)

Examples:

    GET /projects/foo/documents.xml
    GET /projects/foo/documents.json
    GET /projects/foo/documents.xml?offset=0&limit=100

## Showing a document

    GET /documents/[id].[format]

Parameters:

- `include`: fetch associated data (optional). Possible value:
  - `attachments`

Examples:

    GET /documents/1.xml
    GET /documents/1.json
    GET /documents/1.json?include=attachments

## Creating a document

    POST /projects/[project_id]/documents.[format]

Parameters:

- `document`: a hash of the document attributes:
  - `title`
  - `description`
  - `category_id`
  - `custom_fields`

Attachments can be added when creating a document, see [Attaching files](rest-api.md#Attaching-files).

Returns `201 Created` on success.

## Updating a document

    PUT /documents/[id].[format]

Parameters:

Same as document creation.

Attachments can be added when updating a document, see [Attaching files](rest-api.md#Attaching-files).

Returns `204 No Content` on success.

## Deleting a document

    DELETE /documents/[id].[format]

Returns `204 No Content` on success.

The existing `view_documents`, `add_documents`, `edit_documents` and `delete_documents` permissions are applied.
