---
source: Rest_Attachments
translated_from_version: 7
---

# 添付ファイル

API でファイルを添付する方法は、共通の事項の[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

## /attachments/:id.:format

### GET

指定した ID の添付ファイルの説明を返します。\
ファイルそのものは、レスポンスの `content_url` 属性の URL からダウンロードできます。

<u>例</u>:

```text
GET /attachments/13.xml
```

<u>レスポンス</u>:

```xml
<attachment>
  <id>6243</id>
  <filename>test.txt</filename>
  <filesize>124</filesize>
  <content_type>text/plain</content_type>
  <description>This is an attachment</description>
  <content_url>http://localhost:3000/attachments/download/6243/test.txt</content_url>
  <author name="Jean-Philippe Lang" id="1"/>
  <created_on>2011-07-18T22:58:40+02:00</created_on>
</attachment>
```

注: API でチケットを取得するときは、`GET /issues/:id.:format?include=attachments` を使うと、添付ファイルも 1 回のリクエストで取得できます。

### PATCH

添付ファイルを更新します。

(まだ説明がありません。詳しくは [#22356](https://www.redmine.org/issues/22356) を参照してください)

### DELETE

添付ファイルを削除します。

<u>例</u>:

```text
DELETE /attachments/6243.json
```
