---
source: Rest_News
translated_from_version: 7
---

# ニュース

## ニュースの一覧

```
GET /news.[format]
GET /projects/[project_id]/news.[format]
```

ニュースを、ページ分割した一覧で返します。`project_id` を指定すると、指定した ID または識別子のプロジェクトのニュースだけを返します。

<u>パラメーター</u>:

- `offset`: レスポンスで飛ばすニュースの数(任意)
- `limit`: 1 ページあたりのニュースの数(任意)

<u>例</u>:

```
GET /news.xml
GET /news.json
GET /projects/foo/news.xml
GET /projects/foo/news.json

Paging example:
GET /news.xml?offset=0&limit=100
GET /news.xml?offset=100&limit=100
```

<u>レスポンス</u>:

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

## ニュースの表示

```
GET /news/[id].[format]
```

<u>パラメーター</u>:

- `include`: 関連するデータを取得します(任意。複数の関連はカンマで区切ります)。指定できる値:
  - `attachments`
  - `comments`
  - `reactions` - 7.1.0 から。ニュースにリアクションしたユーザーを返します。`comments` と一緒に指定すると、各コメントへのリアクションも返します。返すのは、リクエストしたユーザーから見えるユーザーだけです。リアクションの機能が無効の場合は何も返しません。レスポンスの形式は[チケットの表示](rest-issues.md#Showing-an-issue)を参照してください。

<u>例</u>:

```
GET /news/2.xml
GET /news/2.json

GET /news/2.xml?include=attachments
GET /news/2.xml?include=comments
GET /news/2.xml?include=reactions
GET /news/2.xml?include=comments,reactions
```

<u>レスポンス</u>:

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

## ニュースの作成

POST /projects/\[project_id\]/news.\[format\]

<u>パラメーター</u>:

- `news` - ニュースの属性のハッシュ:
  - `title`
  - `summary`
  - `description`

ニュースの作成時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

<u>例</u>:

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

## ニュースの更新

PUT /news/\[id\].\[format\]

<u>パラメーター</u>:

- `news` - ニュースの属性のハッシュ:
  - `title`
  - `summary`
  - `description`

ニュースの更新時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

<u>例</u>:

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

## ニュースの削除

DELETE /news/\[id\].\[format\]
