---
source: Rest_TimeEntries
translated_from_version: 15
---

# 作業時間

(注: Redmine のバージョンによっては、パス /time_entries.xml に別の拡張子が必要な場合があります。たとえば 2.5 は \*.json で動きます(http://www.redmine.org/boards/2/topics/48933?r=48934#message-48934)。プラグインでは拡張子なしの場合もあります)

# 作業時間

## 作業時間の一覧

GET /time_entries.xml

作業時間を返します。

<u>パラメーター</u>:

- `offset`
- `limit`
- `user_id`
- `project_id`
- `spent_on`
- …

### `project_id` フィルター

プロジェクトの ID で絞り込むときは、プロジェクトの数値の ID か、文字列の識別子を使えます。例:

```
...&project_id=123

...&project_id=my-custom-project
```

### `spent_on` フィルター

日付で絞り込むときは、独自の構文で日付の下限・上限を指定できます。

```
/time_entries.json?project_id=338&from=2019-01-01&to=2019-01-03&limit=100
```

## 作業時間の表示

GET /time_entries/\[id\].xml

指定した ID の作業時間を返します。

## 作業時間の作成

POST /time_entries.xml

作業時間を作成します。

<u>パラメーター</u>:

- `time_entry`(必須): 作業時間の属性のハッシュ。次のものを含みます:
  - `issue_id` または `project_id`(どちらか一方が必須): 時間を記録するチケットの ID またはプロジェクトの ID(どちらも整数)。プロジェクトの ID は API でしか調べられないことに注意してください(例: /projects.json)
  - `spent_on`: 作業した日(デフォルトは今日)。形式は `2020-12-24` などです
  - `hours`(必須): 作業時間(時間)
  - `activity_id`: 作業分類の ID。Redmine でデフォルトの作業分類を定義していない場合は必須です。
  - `comments`: 作業時間の短い説明(最大 255 文字)
  - `user_id`: ほかのユーザーの代わりに時間を記録する場合に指定するユーザーの ID

<u>レスポンス</u>:

- `201 Created`: 作業時間を作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、作業時間を作成できませんでした(レスポンスの本文にエラーメッセージが入ります)

## 作業時間の更新

PUT /time_entries/\[id\].xml

指定した ID の作業時間を更新します。

<u>パラメーター</u>:

- `time_entry`(必須): 作業時間の属性のハッシュ(上と同じ)

<u>レスポンス</u>:

- `204 No Content`: 作業時間を更新しました
- `422 Unprocessable Entity`: 検証に失敗したため、作業時間を更新できませんでした(レスポンスの本文にエラーメッセージが入ります)

## 作業時間の削除

DELETE /time_entries/\[id\].xml

指定した ID の作業時間を削除します。
