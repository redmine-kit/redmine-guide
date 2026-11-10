---
source: Rest_IssueRelations
translated_from_version: 10
---

# 関連するチケット

## /issues/:issue_id/relations.:format

### GET

指定した ID(:issue_id)のチケットの関連を返します。

<u>XML の例</u>:

```text
GET /issues/8470/relations.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relations type="array">
  <relation>
    <id>1819</id>
    <issue_id>8470</issue_id>
    <issue_to_id>8469</issue_to_id>
    <relation_type>relates</relation_type>
    <delay/>
  </relation>
  <relation>
    <id>1820</id>
    <issue_id>8470</issue_id>
    <issue_to_id>8467</issue_to_id>
    <relation_type>relates</relation_type>
    <delay/>
  </relation>
</relations>
```

<u>JSON の例</u>:

```text
GET /issues/8470/relations.json
```

<u>レスポンス</u>:

```json
{
    "relations": [
        {
            "delay": null,
            "id": 1819,
            "issue_id": 8470,
            "issue_to_id": 8469,
            "relation_type": "relates"
        },
        {
            "delay": null,
            "id": 1820,
            "issue_id": 8470,
            "issue_to_id": 8467,
            "relation_type": "relates"
        }
    ]
}
```

注: チケットを取得するときは、`/issues/:id.:format?include=relations` を使うと、関連も 1 回のリクエストで取得できます。

### POST

指定した ID(:issue_id)のチケットに関連を作成します。

<u>パラメーター</u>:

- `relation`(必須): 関連の属性のハッシュ。次のものを含みます:
  - `issue_to_id`(必須): 関連するチケットの ID
  - `relation_type`(明示する場合は必須。デフォルトは「relates」): 関連の種類(「relates」、「duplicates」、「duplicated」、「blocks」、「blocked」、「precedes」、「follows」、「copied_to」、「copied_from」のどれか)
  - `delay`(任意): 「precedes」または「follows」の関連の遅延

<u>レスポンス</u>:

- `201 Created`: 関連を作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、関連を作成できませんでした(レスポンスの本文にエラーメッセージが入ります)

<u>例</u>:

```text
POST /issues/83/relations.xml
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relation>
  <issue_to_id>82</issue_to_id>
  <relation_type>relates</relation_type>
</relation>
```

```text
POST /issues/83/relations.json
```

```json
{
  "relation": {
    "issue_to_id": 82,
    "relation_type": "relates"
  }
}
```

## /relations/:id.:format

### GET

指定した ID の関連を返します。

<u>XML の例</u>:

```text
GET /relations/1819.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<relation>
  <id>1819</id>
  <issue_id>8470</issue_id>
  <issue_to_id>8469</issue_to_id>
  <relation_type>relates</relation_type>
  <delay/>
</relation>
```

<u>JSON の例</u>:

```text
GET /relations/1819.json
```

<u>レスポンス</u>:

```json
{
    "relation": {
        "delay": null,
        "id": 1819,
        "issue_id": 8470,
        "issue_to_id": 8469,
        "relation_type": "relates"
    }
}
```

### DELETE

指定した ID の関連を削除します。

<u>レスポンス</u>:

- `204 No Content`: 関連を削除しました
- `422 Unprocessable Entity`: 関連を削除できませんでした(レスポンスの本文にエラーメッセージが入ります)
