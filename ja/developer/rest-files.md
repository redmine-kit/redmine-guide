---
source: Rest_Files
translated_from_version: 4
---

# ファイル

## /projects/:project_id/files.:format

### GET

指定した ID または識別子(:project_id)のプロジェクトにあるファイルを返します。

<u>例</u>:

```
GET /projects/foo/files.xml
GET /projects/1/files.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<files type="array">
  <file>
    <id>12</id>
    <filename>foo-1.0-setup.exe</filename>
    <filesize>74753799</filesize>
    <content_type>application/octet-stream</content_type>
    <description>Foo App for Windows</description>
    <content_url>http://localhost:3000/attachments/download/12/foo-1.0-setup.exe</content_url>
    <author id="1" name="Redmine Admin"/>
    <created_on>2017-01-04T09:12:32Z</created_on>
    <version id="2" name="1.0"/>
    <digest>1276481102f218c981e0324180bafd9f</digest>
    <downloads>12</downloads>
  </file>
  <file>
    <id>11</id>
    <filename>foo-1.0.dmg</filename>
    <filesize>6886287</filesize>
    <content_type>application/x-octet-stream</content_type>
    <description>Foo App for macOS</description>
    <content_url>http://localhost:3000/attachments/download/11/foo-1.0.dmg</content_url>
    <author id="1" name="Redmine Admin"/>
    <created_on>2017-01-04T09:12:07Z</created_on>
    <version id="2" name="1.0"/>
    <digest>14758f1afd44c09b7992073ccf00b43d</digest>
    <downloads>5</downloads>
  </file>
</files>
```

### POST

指定した ID または識別子(:project_id)のプロジェクトにファイルをアップロードします。

<u>パラメーター</u>:

- `file`(必須): ファイルの属性のハッシュ。次のものを含みます:
  - `token`(必須): アップロードしたファイルのトークン。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。
  - `version_id`
  - `filename`
  - `description`

<u>例</u>:

```
POST /projects/1/files.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0"?>
<file>
  <token>21.01a1d7b1c2ffcbbc9ecf14debeec27d8</token>
  <version_id>2</version_id>
  <filename>foo-1.0-src.tar.tgz</filename>
  <description>Foo App source code</description>
</file>
```
