---
source: Rest_api_with_curl
translated_from_version: 10
---

# cURL で REST API を使う

[curl](http://curl.haxx.se/) は、さまざまなプロトコルでデータを転送するコマンドラインのツールです。Redmine の REST API とのやり取りに使えます。

## JSON を使う

チケットを更新するコマンドの簡単な例です。

```sh
curl -v -H "Content-Type: application/json" -X PUT --data-binary "@388.json" -u login:password http://redmine/issues/388.json
curl -v -H "Content-Type: application/json" -X PUT --data-binary "@388.json" -H "X-Redmine-API-Key: xxxx" http://redmine/issues/388.json
```

Redmine に送るデータのファイル (上の例では 388.json) は、次のようになります。

```json
{
  "issue": {
    "subject": "subject123",
    "notes": "Changing the subject"
  }
}
```

注: 送るデータの形式に合わせて、`Content-Type` ヘッダーを設定する必要があります。次の値のどれかにします。

- `application/json`
- `application/xml`

## XML を使う

カスタムフィールドのあるチケットを作成するコマンドの簡単な例です。

```sh
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -u login:password http://redmine/issues.xml
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -H "X-Redmine-API-Key: xxxx" http://redmine/issues.xml
```

issue.xml の内容は次のとおりです。

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

## テキスト書式

テキスト書式を使う場合 (たとえばプロジェクトの Wiki ページを更新する場合) は、ファイルの読み込みに curl のオプション `--data` ではなく `--data-binary` を使ってください。そうすることで初めて、curl は改行をそのまま送り、書式がすべて保たれます。

```sh
curl -v -H "Content-Type: application/xml" -X PUT --data-binary "@wiki.xml" -u login:password http://redmine/projects/foo/wiki/page_test.xml
```

wiki.xml の内容は次のとおりです。

```xml
<?xml version="1.0"?>
<wiki_page>
<text>
h1. TITLE

 %{font-size:14pt}SUBTITLE%
</text>
</wiki_page>
```

## ファイルの添付

image.png を添付したチケットを作成するには、まずこのファイルをアップロードする必要があります。

```sh
curl --data-binary "@image.png" -H "Content-Type: application/octet-stream" -X POST -u login:password http://redmine/uploads.xml?filename=image.png

# 201 response
<upload>
  <token>7167.ed1ccdb093229ca1bd0b043618d88743</token>
</upload>
```

続けて、トークンを使ってチケットを作成します。

```sh
curl -v -H "Content-Type: application/xml" -X POST --data-binary "@issue.xml" -u login:password http://redmine/issues.xml
```

issue.xml の内容は次のとおりです。

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
