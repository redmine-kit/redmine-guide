---
source: Rest_api_with_curl
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_curl
source_version: 10
source_updated_on: '2019-10-18T11:18:04Z'
---

# Using the REST API with cURL

[curl](http://curl.haxx.se/) is a command-line tool for transferring data using various protocols. It can be used to interact with the Redmine REST API.

## Using JSON

Here is a simple example of a command that can be used to update an issue:

```text
curl -v -H "Content-Type: application/json" -X PUT --data-binary "@388.json" -u login:password http://redmine/issues/388.json
curl -v -H "Content-Type: application/json" -X PUT --data-binary "@388.json" -H "X-Redmine-API-Key: xxxx" http://redmine/issues/388.json
```

The file that contains the data sent to Redmine (388.json in the example above) would look like this:

```json
{
  "issue": {
    "subject": "subject123",
    "notes": "Changing the subject"
  }
}
```

Note: it’s required to set the `Content-Type` header according to the format of the data you are sending. It must be set to one the following values:

- `application/json`
- `application/xml`

## Using XML

Here is a simple example of a command that can be used to create an issue with custom fields:

```text
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -u login:password http://redmine/issues.xml
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -H "X-Redmine-API-Key: xxxx" http://redmine/issues.xml
```

Where issue.xml content is:

```xml
<?xml version="1.0" encoding="ISO-8859-1" ?>
<issue>
  <subject>API custom fields</subject>
  <project_id>1</project_id>
  <tracker_id>2</tracker_id>
  <custom_fields type="array">
    <custom_field>
      <id>2</id>
      <value>Fixed</value>
    </custom_field>
    <custom_field>
      <id>1</id>
      <value>0.8.2</value>
    </custom_field>
  </custom_fields>
</issue>
```

## Text formatting

If you want to use some text formatting (e.g to update a wiki page on your project), you should make sure to use curl’s option `--data-binary` instead of `--data` to load the file. Only that way, curl will send newline characters unchanged and will retain all formatting.

```text
curl -v -H "Content-Type: application/xml" -X PUT --data-binary "@wiki.xml" -u login:password http://redmine/projects/foo/wiki/page_test.xml
```

Where wiki.xml content is:

```xml
<?xml version="1.0"?>
<wiki_page>
<text>
h1. TITLE

 %{font-size:14pt}SUBTITLE%
</text>
</wiki_page>
```

## Attaching files

If you want to create an issue with image.png attached, you need to upload this file first:

```text
curl --data-binary "@image.png" -H "Content-Type: application/octet-stream" -X POST -u login:password http://redmine/uploads.xml?filename=image.png

# 201 response
<upload>
  <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
</upload>
```

Then, use the token to create the issue:

```text
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -u login:password http://redmine/issues.xml
```

Where issue.xml content is:

```xml
<?xml version="1.0" encoding="ISO-8859-1" ?>
<issue>
  <subject>Issue with attachment</subject>
  <project_id>1</project_id>
  <uploads type="array">
    <upload>
      <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
      <filename>image.png</filename>
      <content_type>image/png</content_type>
    </upload>
  </uploads>
</issue>
```
