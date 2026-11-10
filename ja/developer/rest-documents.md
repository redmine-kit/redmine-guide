---
source: Rest_Documents
translated_from_version: 1
---

# 文書

注: 文書の API は Redmine 7.0.3 では利用できません。

## 文書の一覧

```text
GET /projects/[project_id]/documents.[format]
```

指定した ID または識別子のプロジェクトの文書を、ページ分割した一覧で返します。

パラメーター:

- `offset`: レスポンスで飛ばす文書の数(任意)
- `limit`: 1 ページあたりの文書の数(任意)

例:

```text
GET /projects/foo/documents.xml
GET /projects/foo/documents.json
GET /projects/foo/documents.xml?offset=0&limit=100
```

## 文書の表示

```text
GET /documents/[id].[format]
```

パラメーター:

- `include`: 関連するデータを取得します(任意)。指定できる値:
  - `attachments`

例:

```text
GET /documents/1.xml
GET /documents/1.json
GET /documents/1.json?include=attachments
```

## 文書の作成

```text
POST /projects/[project_id]/documents.[format]
```

パラメーター:

- `document`: 文書の属性のハッシュ:
  - `title`
  - `description`
  - `category_id`
  - `custom_fields`

文書の作成時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

成功すると `201 Created` を返します。

## 文書の更新

```text
PUT /documents/[id].[format]
```

パラメーター:

文書の作成と同じです。

文書の更新時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

成功すると `204 No Content` を返します。

## 文書の削除

```text
DELETE /documents/[id].[format]
```

成功すると `204 No Content` を返します。

既存の権限 `view_documents`、`add_documents`、`edit_documents`、`delete_documents` が適用されます。
