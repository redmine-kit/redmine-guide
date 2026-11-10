---
source: Rest_Search
translated_from_version: 2
---

# 検索

## /search.:format

### GET

指定した条件のパラメーターで検索した結果を返します。

<u>パラメーター</u>:

- `offset`: レスポンスで飛ばす結果の数(任意)
- `limit`: レスポンスに含める結果の数(任意)
- `q`: 検索する文字列。空白「 」で区切って複数の値を指定できます。

任意のフィルター:

- `scope`: 検索の範囲
  - 「all」: すべてのプロジェクトを検索
  - 「my_projects」: 参加しているプロジェクトを検索
  - 「subprojects」: プロジェクトを指定したとき、サブプロジェクトも含める
- `all_words`: すべての検索文字列に一致するものだけにするかどうか
- `titles_only`: タイトルだけを対象にするかどうか
- `issues`: チケットを含めるかどうか
- `news`: ニュースを含めるかどうか
- `documents`: 文書を含めるかどうか
- `changesets`: 更新履歴を含めるかどうか
- `wiki_pages`: Wikiページを含めるかどうか
- `messages`: メッセージを含めるかどうか
- `projects`: プロジェクトを含めるかどうか
- `open_issues`: 未完了のチケットに絞り込みます。
- `attachments`: 説明と添付ファイルで絞り込みます
  - 「0」: 説明だけを検索
  - 「1」: 説明と添付ファイルを検索
  - 「only」: 添付ファイルだけを検索

<u>例</u>:

```text
GET /search.xml?q=query_string

Paging example:
GET /search.xml?q=query_string&offset=0&limit=100

Filtering issues and wikis example:
GET /search.xml?q=issue_keyword wiki_keyword&issues=1&wiki_pages=1
```

<u>レスポンス</u>:

```text
<results total_count="2" offset="0" limit="25" type="array">
  <result>
    <id>5</id>
    <title>Wiki: Wiki_Page_Name</title>
    <type>wiki-page</type>
    <url>
    http://www.redmine.org/projects/new_crm_dev/wiki/Wiki_Page_Name
    </url>
    <description>h1. Wiki Page Name wiki_keyword</description>
    <datetime>2016-03-25T05:23:35Z</datetime>
  </result>
  <result>
    <id>10</id>
    <title>Issue #10 (Closed): Issue_Title</title>
    <type>issue closed</type>
    <url>http://www.redmin.org/issues/10</url>
    <description>issue_keyword</description>
    <datetime>2016-03-24T05:18:59Z</datetime>
  </result>
</results>
```
