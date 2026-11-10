---
source: Rest_api
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api
source_version: 106
source_updated_on: '2026-09-16T08:48:49Z'
---

# Redmine API

Redmine exposes some of its data through a REST API. This API provides access and basic CRUD operations (create, update, delete) for the resources described below. The API supports both [XML](http://en.wikipedia.org/wiki/Xml) and [JSON](http://en.wikipedia.org/wiki/JSON) formats.

## API Description

| Resource | Status | Notes | Availability |
|----|----|----|----|
| [Issues](rest-issues.md) | Stable |  | 1.0 |
| [Projects](rest-projects.md) | Stable |  | 1.0 |
| [Project Memberships](rest-memberships.md) | Alpha |  | 1.4 |
| [Users](rest-users.md) | Stable |  | 1.1 |
| [Time Entries](rest-time-entries.md) | Stable |  | 1.1 |
| [News](rest-news.md) | Stable | CRUD operations other than `index` were added in 4.1 | 1.1 |
| [Issue Relations](rest-issue-relations.md) | Alpha |  | 1.3 |
| [Versions](rest-versions.md) | Alpha |  | 1.3 |
| [Wiki Pages](rest-wiki-pages.md) | Alpha |  | 2.2 |
| [Documents](rest-documents.md) |  |  | 7.1 |
| [Queries](rest-queries.md) | Alpha |  | 1.3 |
| [Attachments](rest-attachments.md) | Beta | Adding attachments via the API added in 1.4 | 1.3 |
| [Issue Statuses](rest-issue-statuses.md) | Alpha | Provides the list of all statuses | 1.3 |
| [Trackers](rest-trackers.md) | Alpha | Provides the list of all trackers | 1.3 |
| [Enumerations](rest-enumerations.md) | Alpha | Provides the list of issue priorities and time tracking activities | 2.2 |
| [Issue Categories](rest-issue-categories.md) | Alpha |  | 1.3 |
| [Roles](rest-roles.md) | Alpha |  | 1.4 |
| [Groups](rest-groups.md) | Alpha |  | 2.1 |
| [Custom Fields](rest-custom-fields.md) | Alpha |  | 2.4 |
| [Search](rest-search.md) | Alpha |  | 3.3 |
| [Files](rest-files.md) | Alpha |  | 3.4 |
| [My account](rest-my-account.md) | Alpha |  | 4.1 |
| [Journals](rest-journals.md) | Alpha |  | 5.0 |

Status legend:

- Stable - feature complete, no major changes planned
- Beta - usable for integrations with some bugs or missing minor functionality
- Alpha - major functionality in place, needs feedback from API users and integrators
- Prototype - very rough implementation, possible major breaking changes mid-version. **Not recommended for integration**
- Planned - planned in a future version, depending on developer availability

You can review the list of all the [API changes for each version](https://www.redmine.org/projects/redmine/issues?set_filter=1&status_id=c&fixed_version_id=*&category_id=32&c)\[\]=tracker&c\[\]=subject&c\[\]=author&group_by=fixed_version&sort=fixed_version:desc,id.

## General topics

### Specify `Content-Type` on `POST`/`PUT` requests

When creating or updating a remote element, the `Content-Type` of the request **MUST** be specified even if the remote URL is suffixed accordingly (e.g. `POST ../issues.json`):

- for JSON content, it must be set to `Content-Type: application/json`.
- for XML content, to `Content-Type: application/xml`.

### Authentication

Most of the time, the API requires authentication. To enable the API-style authentication, you have to check **Enable REST API** in Administration -\> Settings -\> API. Then, authentication can be done in 2 different ways:

- using your regular login/password via HTTP Basic authentication.
- using your API key which is a handy way to avoid putting a password in a script. The API key may be attached to each request in one of the following way:
  - passed in as a “key” parameter
  - passed in as a username with a random password via HTTP Basic authentication
  - passed in as a “X-Redmine-API-Key” HTTP header (added in Redmine 1.1.0)

You can find your API key on your account page ( /my/account ) when logged in, on the right-hand pane of the default layout.

### User Impersonation

As of Redmine 2.2.0, you can impersonate user through the REST API by setting the `X-Redmine-Switch-User` header of your API request. It must be set to a user login (eg. `X-Redmine-Switch-User: jsmith`). This only works when using the API with an administrator account, this header will be ignored when using the API with a regular user account.

If the login specified with the `X-Redmine-Switch-User` header does not exist or is not active, you will receive a 412 error response.

### Collection resources and pagination

The response to a GET request on a collection resources (eg. `/issues.xml`, `/users.xml`) generally won’t return all the objects available in your database. Redmine version:1.1.0 introduces a common way to query such resources using the following parameters:

- `offset`: the offset of the first object to retrieve
- `limit`: the number of items to be present in the response (default is 25, maximum is 100)
- `page`: the page number to retrieve. It is converted to an offset using the selected limit. For example, `page=3&limit=100` is equivalent to `offset=200&limit=100`. If both `offset` and `page` are specified, `offset` takes precedence.

Examples:

    GET /issues.xml
    => returns the 25 first issues

    GET /issues.xml?limit=100
    => returns the 100 first issues

    GET /issues.xml?offset=30&limit=10
    => returns 10 issues from the 30th

    GET /issues.xml?page=3&limit=10
    => returns 10 issues starting from the 21st issue

Responses to GET requests on collection resources provide information about the total object count available in Redmine and the offset/limit used for the response. Examples:

    GET /issues.xml

    <issues type="array" total_count="2595" limit="25" offset="0">
      ...
    </issues>

    GET /issues.json

    { "issues":[...], "total_count":2595, "limit":25, "offset":0 }

Note: if you’re using a REST client that does not support such top level attributes (total_count, limit, offset), you can set the `nometa` parameter or `X-Redmine-Nometa` HTTP header to 1 to get responses without them. Example:

    GET /issues.xml?nometa=1

    <issues type="array">
      ...
    </issues>

### Fetching associated data

Since of version:1.1.0, you have to explicitly specify the associations you want to be included in the query result by appending the `include` parameter to the query url :

Example:

To retrieve issue journals with its description:

    GET /issues/296.xml?include=journals

    <issue>
      <id>296</id>
      ...
      <journals type="array">
      ...
      </journals>
    </issue>

You can also load multiple associations using a comma separated list of items.

Example:

    GET /issues/296.xml?include=journals,changesets

    <issue>
      <id>296</id>
      ...
      <journals type="array">
      ...
      </journals>
      <changesets type="array">
      ...
      </changesets>
    </issue>

### Working with custom fields

Most of the Redmine objects support custom fields. Their values can be found in the `custom_fields` attributes.

XML Example:

    GET /issues/296.xml      # an issue with 2 custom fields

    <issue>
      <id>296</id>
      ...
      <custom_fields type="array">
        <custom_field name="Affected version" id="1">
          <value>1.0.1</value>
        </custom_field>
        <custom_field name="Resolution" id="2">
          <value>Fixed</value>
        </custom_field>
      </custom_fields>
    </issue>

JSON Example:

    GET /issues/296.json      # an issue with 2 custom fields

    {"issue":
      {
        "id":8471,
        ...
        "custom_fields":
          [
            {"value":"1.0.1","name":"Affected version","id":1},
            {"value":"Fixed","name":"Resolution","id":2}
          ]
      }
    }

You can also set/change the values of the custom fields when creating/updating an object using the same syntax (except that the custom field name is not required).

XML Example:

    PUT /issues/296.xml

    <issue>
      <subject>Updating custom fields of an issue</subject>
      ...
      <custom_fields type="array">
        <custom_field id="1">
          <value>1.0.2</value>
        </custom_field>
        <custom_field id="2">
          <value>Invalid</value>
        </custom_field>
      </custom_fields>
    </issue>

Note: the `type="array"` attribute on `custom_fields` XML tag is strictly required.

JSON Example:

    PUT /issues/296.json

    {"issue":
      {
        "subject":"Updating custom fields of an issue",
        ...
        "custom_fields":
          [
            {"value":"1.0.2","id":1},
            {"value":"Invalid","id":2}
          ]
      }
    }

### Attaching files

Support for adding attachments through the REST API is added in Redmine version:1.4.0.

First, you need to upload each file with a POST request to `/uploads.xml` (or `/uploads.json`). The request body should be the content of the file you want to attach and the `Content-Type` header must be set to `application/octet-stream` (otherwise you’ll get a `406 Not Acceptable` response). If the upload succeeds, you get a 201 response that contains a token for your uploaded file.

Then you can use this token to attach your uploaded file to a new or an existing issue.

Note: as of Redmine version:7.1.0, the `content_type` attribute is ignored. Redmine detects the content type from the file contents instead. The attribute has always been optional, so removing it from your requests is safe with any version of Redmine.

<u>XML Example</u>

First, upload your file:

    POST /uploads.xml?filename=image.png
    Content-Type: application/octet-stream
    ...
    (request body is the file content)

    # 201 response
    <upload>
      <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
    </upload>

Then create the issue using the upload token:

    POST /issues.xml
    <issue>
      <project_id>1</project_id>
      <subject>Creating an issue with a uploaded file</subject>
      <uploads type="array">
        <upload>
          <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
          <filename>image.png</filename>
          <description>An optional description here</description>
          <content_type>image/png</content_type>
        </upload>
      </uploads>
    </issue>

If you try to upload a file that exceeds the maximum size allowed, you get a 422 response:

    POST /uploads.xml?filename=image.png
    Content-Type: application/octet-stream
    ...
    (request body larger than the maximum size allowed)

    # 422 response
    <errors>
      <error>This file cannot be uploaded because it exceeds the maximum allowed file size (1024000)</error>
    </errors>

<u>JSON Example</u>

First, upload your file:

    POST /uploads.json?filename=image.png
    Content-Type: application/octet-stream
    ...
    (request body is the file content)

    # 201 response
    {"upload":{"token":"7167.ed1ccdb093229ca1bd0b043618d88743"}}

Then create the issue using the upload token:

    POST /issues.json
    {
      "issue": {
        "project_id": "1",
        "subject": "Creating an issue with a uploaded file",
        "uploads": [
          {"token": "7167.ed1ccdb093229ca1bd0b043618d88743", "filename": "image.png", "content_type": "image/png"}
        ]
      }
    }

You can also upload multiple files (by doing multiple POST requests to `/uploads.json`), then create an issue with multiple attachments:

    POST /issues.json
    {
      "issue": {
        "project_id": "1",
        "subject": "Creating an issue with a uploaded file",
        "uploads": [
          {"token": "7167.ed1ccdb093229ca1bd0b043618d88743", "filename": "image1.png", "content_type": "image/png"},
          {"token": "7168.d595398bbb104ed3bba0eed666785cc6", "filename": "image2.png", "content_type": "image/png"}
        ]
      }
    }

### Validation errors

When trying to create or update an object with invalid or missing attribute parameters, you will get a `422 Unprocessable Entity` response. That means that the object could not be created or updated. In such cases, the response body contains the corresponding error messages:

<u>XML Example</u>:

    # Request with invalid or missing attributes
    POST /users.xml
    <user>
      <login>john</login>
      <lastname>Smith</lastname>
      <mail>john</mail>
    </uer>

    # 422 response with the error messages in its body
    <errors type="array">
      <error>First name can't be blank</error>
      <error>Email is invalid</error>
    </errors>

<u>JSON Example</u>:

    # Request with invalid or missing attributes
    POST /users.json
    {
      "user":{
        "login":"john",
        "lastname":"Smith",
        "mail":"john"
      }
    }

    # 422 response with the error messages in its body
    {
      "errors":[
        "First name can't be blank",
        "Email is invalid"
      ]
    }

### JSONP Support

Redmine 2.1.0+ API supports [JSONP](http://en.wikipedia.org/wiki/JSONP) to request data from a Redmine server in a different domain (say, with JQuery). The callback can be passed using the `callback` or `jsonp` parameter. As of Redmine 2.3.0, JSONP support is optional and disabled by default, you can enable it by checking **Enable JSONP support** in Administration -\> Settings -\> API.

Example:

    GET /issues.json?callback=myHandler

    myHandler({"issues":[ ... ]})

## API Usage in various languages/tools

- [Ruby](rest-api-with-ruby.md)
- [PHP](rest-api-with-php.md)
- [Python](https://www.redmine.org/projects/redmine/wiki/Rest_api_with_python)
- [Perl](rest-api-with-perl.md)
- [Java](rest-api-with-java.md)
- [cURL](rest-api-with-curl.md)
- [Drupal Redmine API module, 2.x branch (currently not stable)](http://drupal.org/project/redmine)
- [.NET](rest-api-with-csharp.md)
- [Delphi](rest-api-with-delphi.md)

## API Change history

This section lists changes to the existing API features that may have broken backward compatibility. New features of the API are listed in the [API Description](rest-api.md#API-Description).

### 2026-08-20: Attachment content type is detected from the file contents (r24959, version:7.1.0)

Redmine no longer uses the content type sent by the client when a file is uploaded. It reads the file and detects the content type itself. The following are ignored:

- the `content_type` attribute in the `uploads` array
- the `content_type` query parameter of `POST /uploads`

Neither returns an error. The value is simply ignored, so existing clients keep working. Only the stored content type changes.

### 2012-01-29: Multiselect custom fields (r8721, version:1.4.0)

Custom fields with multiple values are now supported in Redmine and may be found in API responses. These custom fields have a `multiple=true attribute` and their `value` attribute is an array.

Example:

    GET /issues/296.json

    {"issue":
      {
        "id":8471,
        ...
        "custom_fields":
          [
            {"value":["1.0.1","1.0.2"],"multiple":true,"name":"Affected version","id":1},
            {"value":"Fixed","name":"Resolution","id":2}
          ]
      }
    }
