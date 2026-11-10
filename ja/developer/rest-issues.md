---
source: Rest_Issues
translated_from_version: 72
---

# チケット

## チケットの一覧

GET /issues.\[format\]

チケットを、ページ分割した一覧で返します。デフォルトでは未完了のチケットだけを返します。

<u>パラメーター</u>:

- `offset`: レスポンスで飛ばすチケットの数(任意)
- `limit`: 1 ページあたりのチケットの数(任意)
- `sort`: 並べ替えに使う列。`:desc` を付けると逆順になります。
- `include`: 関連するデータを取得します(任意。複数の関連はカンマで区切ります)。指定できる値:
  - `attachments` - 3.4.0 から
  - `relations`

任意のフィルター:

- `issue_id`: 指定した ID のチケットを取得します。ID を「,」で区切ると、複数のチケットを取得できます。
- `project_id`: 指定した ID(識別子ではなく数値)のプロジェクトのチケットを取得します。
- `subproject_id`: 指定した ID のサブプロジェクトのチケットを取得します。`project_id=XXX&subproject_id=!*` とすると、指定したプロジェクトのチケットだけを取得し、サブプロジェクトのチケットは含めません。
- `tracker_id`: 指定した ID のトラッカーのチケットを取得します
- `status_id`: 指定したステータスの ID のチケットだけを取得します。指定できる値: `open`、`closed`、`*`(未完了と完了の両方)、ステータスの ID
- `assigned_to_id`: 指定した ID のユーザーが担当者のチケットを取得します。ID の代わりに `me` を指定すると、ログインしているユーザー(API キーか HTTP 認証による)のすべてのチケットを取得します
- `parent_id`: 親チケットが指定した ID のチケットを取得します。
- `cf_x`: ID が `x` のカスタムフィールドの値が指定した値のチケットを取得します(カスタムフィールドで「フィルタとして使用」がオンになっている必要があります)。
- …

注: 「\>」、「\<」、「=」を含む演算子は、正しく解釈されるように 16 進数でエンコードしてください。ほとんどの高機能な API クライアントはデフォルトでそうしてくれますが、わかりやすさのため、以下の例はそうした機能を前提にせずに書いています。

<u>例</u>:

```text
GET /issues.xml
GET /issues.xml?issue_id=1
GET /issues.xml?issue_id=1,2
GET /issues.xml?project_id=2
GET /issues.xml?project_id=2&tracker_id=1
GET /issues.xml?assigned_to_id=6
GET /issues.xml?assigned_to_id=me
GET /issues.xml?status_id=closed
GET /issues.xml?status_id=*
GET /issues.xml?cf_1=abcdef
GET /issues.xml?sort=category:desc,updated_on


Paging example:
GET /issues.xml?offset=0&limit=100
GET /issues.xml?offset=100&limit=100

To fetch issues for a date range (uncrypted filter is "><2012-03-01|2012-03-07") :
GET /issues.xml?created_on=%3E%3C2012-03-01|2012-03-07

To fetch issues created after a certain date (uncrypted filter is ">=2012-03-01") :
GET /issues.xml?created_on=%3E%3D2012-03-01

Or before a certain date (uncrypted filter is "<= 2012-03-07") :
GET /issues.xml?created_on=%3C%3D2012-03-07

To fetch issues created after a certain timestamp (uncrypted filter is ">=2014-01-02T08:12:32Z") :
GET /issues.xml?created_on=%3E%3D2014-01-02T08:12:32Z

To fetch issues updated after a certain timestamp (uncrypted filter is ">=2014-01-02T08:12:32Z") :
GET /issues.xml?updated_on=%3E%3D2014-01-02T08:12:32Z

To fetch issues for which custom field 4 contains the substring "foo" :
GET /issues.xml?cf_4=~foo
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<issues type="array" count="1640">
  <issue>
    <id>4326</id>
    <project name="Redmine" id="1"/>
    <tracker name="Feature" id="2"/>
    <status name="New" id="1"/>
    <priority name="Normal" id="4"/>
    <author name="John Smith" id="10106"/>
    <category name="Email notifications" id="9"/>
    <subject>
      Aggregate Multiple Issue Changes for Email Notifications
    </subject>
    <description>
      This is not to be confused with another useful proposed feature that
      would do digest emails for notifications.
    </description>
    <start_date>2009-12-03</start_date>
    <due_date></due_date>
    <done_ratio>0</done_ratio>
    <estimated_hours></estimated_hours>
    <custom_fields>
      <custom_field name="Resolution" id="2">Duplicate</custom_field>
      <custom_field name="Texte" id="5">Test</custom_field>
      <custom_field name="Boolean" id="6">1</custom_field>
      <custom_field name="Date" id="7">2010-01-12</custom_field>
    </custom_fields>
    <created_on>Thu Dec 03 15:02:12 +0100 2009</created_on>
    <updated_on>Sun Jan 03 12:08:41 +0100 2010</updated_on>
  </issue>
  <issue>
    <id>4325</id>
    ...
  </issue>
</issues>
```

## チケットの表示

```text
GET /issues/[id].[format]
```

<u>パラメーター</u>:

- `include`: 関連するデータを取得します(任意。複数の関連はカンマで区切ります)。指定できる値:
  - `children`
  - `attachments`
  - `relations`
  - `changesets`
  - `journals` - 詳しくは [Issue journals](https://www.redmine.org/projects/redmine/wiki/Rest_IssueJournals) を参照してください。
  - `watchers` - 2.3.0 から
  - `allowed_statuses` - 5.0.x から。次のことに基づいて、変更できるステータス(チケットの編集フォームと同じ値)を返します:
    - チケットの現在のトラッカー、チケットの現在のステータス、メンバーのロール(定義されたワークフロー)
    - 未完了の子チケットがあるかどうか
    - ブロックしている未完了のチケットがあるかどうか
    - 完了した親チケットがあるかどうか
  - `reactions` - 7.1.0 から。チケットにリアクションしたユーザーを返します。`journals` と一緒に指定すると、各履歴へのリアクションも返します。返すのは、リクエストしたユーザーから見えるユーザーだけです。リアクションの機能が無効の場合は何も返しません。Redmine 7.0.3 では利用できません。

<u>例</u>:

```text
GET /issues/2.xml
GET /issues/2.json

GET /issues/2.xml
GET /issues/2.xml?include=attachments
GET /issues/2.xml?include=attachments,journals
GET /issues/2.xml?include=reactions
GET /issues/2.xml?include=journals,reactions
```

<u>レスポンス</u>(`include=reactions`):

```xml
<reactions type="array">
  <reaction>
    <user id="2" name="John Smith"/>
  </reaction>
</reactions>
```

## チケットの作成

POST /issues.\[format\]

<u>パラメーター</u>:

- `issue` - チケットの属性のハッシュ:
  - `project_id`
  - `tracker_id`
  - `status_id`
  - `priority_id`
  - `subject`
  - `description`
  - `category_id`
  - `fixed_version_id` - 「対象バージョン」の ID(以前は「Fixed Version」と呼ばれており、API では今もその名前です)
  - `assigned_to_id` - チケットの担当者のユーザーの ID(今のところ、名前で割り当てる仕組みはありません)
  - `parent_issue_id` - 親チケットの ID
  - `custom_fields` - [カスタムフィールドの扱い](rest-api.md#Working-with-custom-fields)を参照
  - `watcher_user_ids` - ウォッチャーに追加するユーザーの ID の配列(2.3.0 から)
  - `is_private` - チケットをプライベートにするかどうかを true か false で指定します
  - `estimated_hours` - チケットの予定工数(時間)

チケットの作成時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

<u>例</u>:

```text
POST /issues.xml
```

```xml
<?xml version="1.0"?>
<issue>
  <project_id>1</project_id>
  <subject>Example</subject>
  <priority_id>4</priority_id>
</issue>
```

```text
POST /issues.json
```

```json
{
  "issue": {
    "project_id": 1,
    "subject": "Example",
    "priority_id": 4
  }
}
```

## チケットの更新

PUT /issues/\[id\].\[format\]

<u>パラメーター</u>:

- `issue` - チケットの属性のハッシュ
  - `project_id`
  - `tracker_id`
  - `status_id`
  - `subject`
  - …
  - `notes` - 更新についてのコメント
  - `private_notes` - コメントがプライベートの場合は true

チケットの更新時に添付ファイルを追加できます。[ファイルの添付](rest-api.md#Attaching-files)を参照してください。

<u>例</u>:

```text
PUT /issues/[id].xml
```

```xml
<?xml version="1.0"?>
<issue>
  <subject>Subject changed</subject>
  <notes>The subject was changed</notes>
</issue>
```

```text
PUT /issues/[id].json
```

```json
{
  "issue": {
    "subject": "Subject changed",
    "notes": "The subject was changed"
  }
}
```

## チケットの削除

DELETE /issues/\[id\].\[format\]

## ウォッチャーの追加

*2.3.0 で追加*

POST /issues/\[id\]/watchers.\[format\]

<u>パラメーター</u>:

- `user_id`(必須): ウォッチャーに追加するユーザーの ID

## ウォッチャーの削除

*2.3.0 で追加*

DELETE /issues/\[id\]/watchers/\[user_id\].\[format\]

<u>パラメーター</u>: *なし*
