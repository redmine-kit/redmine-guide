---
source: Rest_News
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_News
source_version: 7
source_updated_on: '2026-08-17T01:25:24Z'
---

# News

## Listing news

    GET /news.[format]
    GET /projects/[project_id]/news.[format]

Returns a paginated list of news items. When `project_id` is given, only news from the project with the given id or identifier is returned.

<u>Parameters</u>:

- `offset`: skip this number of news items in response (optional)
- `limit`: number of news items per page (optional)

<u>Examples</u>:

    GET /news.xml
    GET /news.json
    GET /projects/foo/news.xml
    GET /projects/foo/news.json

    Paging example:
    GET /news.xml?offset=0&limit=100
    GET /news.xml?offset=100&limit=100

<u>Response</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<news type="array" limit="25" total_count="2" offset="0">
  <news>
    <id>54</id>
    <project name="Redmine" id="1"/>
    <author name="Jean-Philippe Lang" id="1"/>
    <title>Redmine 1.1.3 released</title>
    <summary/>
    <description>Redmine 1.1.3 has been released</description>
    <created_on>2011-04-29T14:00:25+02:00</created_on>
  </news>
  <news>
    <id>53</id>
    <project name="Redmine" id="1"/>
    <author name="Jean-Philippe Lang" id="1"/>
    <title>Redmine 1.1.2 bug/security fix released</title>
    <summary/>
    <description>Redmine 1.1.2 has been released</description>
    <created_on>2011-03-07T21:07:03+01:00</created_on>
  </news>
</news>
```

## Showing a news item

    GET /news/[id].[format]

<u>Parameters</u>:

- `include`: fetch associated data (optional, use comma to fetch multiple associations). Possible values:
  - `attachments`
  - `comments`
  - `reactions` - Since 7.1.0, Returns the users who reacted to the news item. Combined with `comments`, the reactions on each comment are returned as well. Only the users that are visible to the requesting user are returned. Nothing is returned if the reactions feature is disabled. See [Showing an issue](rest-issues.md#Showing-an-issue) for the response format.

<u>Examples</u>:

    GET /news/2.xml
    GET /news/2.json

    GET /news/2.xml?include=attachments
    GET /news/2.xml?include=comments
    GET /news/2.xml?include=reactions
    GET /news/2.xml?include=comments,reactions

<u>Response</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<news>
  <id>54</id>
  <project name="Redmine" id="1"/>
  <author name="Jean-Philippe Lang" id="1"/>
  <title>Redmine 1.1.3 released</title>
  <summary/>
  <description>Redmine 1.1.3 has been released</description>
  <created_on>2011-04-29T14:00:25+02:00</created_on>
</news>
```

## Creating a news item

POST /projects/\[project_id\]/news.\[format\]

<u>Parameters</u>:

- `news` - A hash of the news attributes:
  - `title`
  - `summary`
  - `description`

Attachments can be added when you create a news item, see [Attaching files](rest-api.md#Attaching-files).

<u>Examples</u>:

    POST /projects/1/news.xml

```xml
<?xml version="1.0"?>
<news>
  <title>Example</title>
  <summary>News summary</summary>
  <description>News description</description>
</news>
```

    POST /projects/1/news.json

```json
{
  "news": {
    "title": "Example",
    "summary": "News summary",
    "description": "News description"
  }
}
```

## Updating a news item

PUT /news/\[id\].\[format\]

<u>Parameters</u>:

- `news` - A hash of the news attributes:
  - `title`
  - `summary`
  - `description`

Attachments can be added when you update a news item, see [Attaching files](rest-api.md#Attaching-files).

<u>Examples</u>:

    PUT /news/[id].xml

```xml
<?xml version="1.0"?>
<news>
  <title>Title changed</title>
  <summary>Summary changed</summary>
  <description>Description changed</description>
</news>
```

    PUT /news/[id].json

```json
{
  "news": {
    "title": "Title changed",
    "summary": "Summary changed",
    "description": "Description changed"
  }
}
```

## Deleting a news item

DELETE /news/\[id\].\[format\]
