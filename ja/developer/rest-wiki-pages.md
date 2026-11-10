---
source: Rest_WikiPages
translated_from_version: 9
---

# Wikiページ

## Wiki のページの一覧の取得

```
GET /projects/foo/wiki/index.xml
```

プロジェクトの Wiki のすべてのページの一覧を返します。

<u>レスポンス</u>:

```
<?xml version="1.0"?>
<wiki_pages type="array">
  <wiki_page>
    <title>UsersGuide</title>
    <version>2</version>
    <created_on>2008-03-09T12:07:08Z</created_on>
    <updated_on>2008-03-09T23:41:33+01:00</updated_on>
  </wiki_page>
  <wiki_page>
    <title>GettingStarted</title>
    <parent title="UsersGuide"/>
    <version>1</version>
    <created_on>2026-06-10T23:18:07Z</created_on>
    <updated_on>2026-06-10T23:18:07Z</updated_on>
  </wiki_page>
  ...
</wiki_pages>
```

## Wiki ページの取得

```
GET /projects/foo/wiki/UsersGuide.xml
```

Wiki ページの詳細を返します。

<u>include できるもの</u>:

- attachments

<u>レスポンス</u>:

```
<?xml version="1.0"?>
<wiki_page>
  <title>UsersGuide</title>
  <parent title="Installation_Guide"/>
  <text>h1. Users Guide
  ...
  ...</text>
  <version>22</version>
  <author id="11" name="John Smith"/>
  <comments>Typo</comments>
  <created_on>2009-05-18T20:11:52Z</created_on>
  <updated_on>2012-10-02T11:38:18Z</updated_on>
</wiki_page>
```

## Wiki ページの古いバージョンの取得

```
GET /projects/foo/wiki/UsersGuide/23.xml
```

Wiki ページの古いバージョンの詳細を返します。

<u>include できるもの</u>:

- attachments

<u>レスポンス</u>:

上と同じです。

## Wiki ページの作成・更新

```
PUT /projects/foo/wiki/UsersGuide.xml
<?xml version="1.0"?>
<wiki_page>
  <text>Example</text>
  <comments>Typo</comments>
  <parent_title>Manuals</parent_title>
</wiki_page>
```

Wiki ページを作成または更新します。

`parent_title` 属性を含めると、既存の Wiki ページの子ページとして作成・更新できます。ルートのページにするには、`parent_title` を省略するか空にします。

既存のページを更新するときは、`version` 属性を含めると、更新しようとしているページが特定のバージョンであることを確認できます(たとえば、ページを取得した後に行われた更新を上書きしたくない場合)。例:

```
PUT /projects/foo/wiki/UsersGuide.xml
<?xml version="1.0"?>
<wiki_page>
  <text>Example</text>
  <comments>Typo</comments>
  <version>18</version>
</wiki_page>
```

この例では、ページの現在のバージョンが 18 の場合だけ更新し、そうでなければ `409 Conflict` のエラーを返します。

### ファイルの添付

<u>JSON の例</u>

まず、ファイルをアップロードします。

```
POST /uploads.json
Content-Type: application/octet-stream
...
(request body is the file content)

# 201 response
{"upload":{"token":"7167.ed1ccdb093229ca1bd0b043618d88743"}}
```

複数のファイルを添付する場合は、1 つずつアップロードし、すべてのトークンを控えておきます。\
続けて、添付ファイルのトークンを使って Wiki ページを作成・更新します(1 つ以上のファイルを、オブジェクトの配列で指定します)。

```
PUT /projects/project_name/wiki/wiki_name.json
{
    "wiki_page": {
        "text": "This is a wiki page with images (like this: !img.png!), and other files.",
        "uploads": [
            {"token": "7167.ed1ccdb093229ca1bd0b043618d88743", "filename": "img.bmp", "content-type": "image/png"},
            {"token": "7168.d595398bbb104ed3bba0eed666785cc6", "filename": "document.pdf", "content-type": "application/pdf"}
        ]
    }
}
```

<u>注:</u>

Wiki ページを作成・更新するときは、text フィールドを必ず指定してください。指定しないと、「Text field can’t be blank」という `422 Unprocessable Entity` のエラーになります。\
テキストを変えない場合は、上の方法で先に Wiki ページを取得し、現在のテキストを更新に含めると、そのまま保てます。

<u>レスポンス</u>:

- `204 No Content`: ページを更新しました
- `201 Created`: ページを作成しました
- `409 Conflict`: 古いページを更新しようとしたときに起きます(上を参照)
- `422 Unprocessable Entity`: 検証に失敗したため、ページを保存できませんでした(レスポンスの本文にエラーメッセージが入ります)

## Wiki ページの削除

```
DELETE /projects/foo/wiki/UsersGuide.xml
```

Wiki ページと、その添付ファイル、履歴を削除します。削除したページが親ページの場合、子ページは削除されず、ルートのページになります。

<u>レスポンス</u>:

- `204 No Content`: ページを削除しました
