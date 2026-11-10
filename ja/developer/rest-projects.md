---
source: Rest_Projects
translated_from_version: 42
---

# プロジェクト

## プロジェクトの一覧

GET /projects.xml

すべてのプロジェクト(すべての公開プロジェクトと、ユーザーがアクセスできる非公開プロジェクト)を返します。

<u>パラメーター</u>:

- `include`: 関連するデータを取得します(任意)。値はカンマ「,」で区切ります。指定できる値:
  - `trackers`
  - `issue_categories`
  - `enabled_modules`(2.6.0 から)
  - `time_entry_activities`(3.4.0 から)
  - `issue_custom_fields`(4.2.0 から)

<u>レスポンス</u>:

```xml
<projects type="array">
  <project>
    <id>1</id>
    <name>Redmine</name>
    <identifier>redmine</identifier>
    <description>
      Redmine is a flexible project management web application written using Ruby on Rails framework.
    </description>
    <created_on>Sat Sep 29 12:03:04 +0200 2007</created_on>
    <updated_on>Sun Mar 15 12:35:11 +0100 2009</updated_on>
    <is_public>true</is_public>
  </project>
  <project>
    <id>2</id>
    ...
  </project>
```

<u>注</u>:

- `is_public` は 2.6.0 から公開されています

## プロジェクトの表示

GET /projects/\[id\].xml

指定した ID または識別子のプロジェクトを返します。

<u>パラメーター</u>:

- `include`: 関連するデータを取得します(任意)。値はカンマ「,」で区切ります。指定できる値:
  - `trackers`
  - `issue_categories`
  - `enabled_modules`(2.6.0 から)
  - `time_entry_activities`(3.4.0 から)
  - `issue_custom_fields`(4.2.0 から)

<u>例</u>:

```
GET /projects/12.xml
GET /projects/12.xml?include=trackers
GET /projects/12.xml?include=trackers,issue_categories
GET /projects/12.xml?include=enabled_modules
GET /projects/redmine.xml
```

<u>レスポンス</u>:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project id="1">
  <name>Redmine</name>
  <identifier>redmine</identifier>
  <description>
    Redmine is a flexible project management web application written using Ruby on Rails framework.
  </description>
  <homepage></homepage>
  <status>1</status>
  <parent id="123" name="foo"/>
  <default_version id="3" name="2.0"/>
  <default_assignee id="2" name="John Smith"/>
  <created_on>Sat Sep 29 12:03:04 +0200 2007</created_on>
  <updated_on>Sun Mar 15 12:35:11 +0100 2009</updated_on>
  <is_public>true</is_public>
</project>
```

<u>注</u>:

- `is_public` は 2.6.0 から公開されています

## プロジェクトの作成

POST /projects.xml

プロジェクトを作成します。

<u>パラメーター</u>:

- `project`(必須): プロジェクトの属性のハッシュ。次のものを含みます:
  - `name`(必須): プロジェクトの名前
  - `identifier`(必須): プロジェクトの識別子
  - `description`
  - `homepage`
  - `is_public`: true または false
  - `parent_id`: 親プロジェクトの番号
  - `inherit_members`: true または false
  - `default_assigned_to_id`: デフォルトの担当者のユーザーの ID。新しいプロジェクトがサブプロジェクトで、メンバーを継承する場合だけ働きます。
  - `default_version_id`: デフォルトのバージョンの ID。既存の共有バージョンでだけ働きます。
  - `tracker_ids`: トラッカーの ID の配列。1 はバグ、など。
  - `enabled_module_names`: モジュールの名前の配列: boards、calendar、documents、files、gantt、issue_tracking、news、repository、time_tracking、wiki。
  - `issue_custom_field_ids`: チケットのカスタムフィールドの ID の配列。
  - `custom_field_values`: `id => value` の組の配列

```
POST /projects.xml

<code class="xml">
<project>
  <name>test project</name>
  <identifier>test</identifier>
  <enabled_module_names>time_tracking</enabled_module_names>
  <enabled_module_names>issue_tracking</enabled_module_names>
</project>
</code>

POST /projects.json

<code class="json">
{
   "project":{
      "name":"Example name",
      "identifier":"example_name",
      "description":"Description of exapmple project",
      "is_public":false,
      "parent_id":1,
      "inherit_members":false,
      "tracker_ids":[
         1,
         2,
         3,
         4,
         5
      ],
      "enabled_module_names":[
         "issue_tracking"
      ],
      "custom_field_values":{
         "1":"VALUE"
      }
   }
}
</code>
```

<u>レスポンス</u>:

- `201 Created`: プロジェクトを作成しました
- `422 Unprocessable Entity`: 検証に失敗したため、プロジェクトを作成できませんでした(レスポンスの本文にエラーメッセージが入ります)

## プロジェクトの更新

PUT /projects/\[id\].xml

指定した ID または識別子のプロジェクトを更新します。

## プロジェクトのアーカイブ

PUT /projects/\[id\]/archive.xml

指定した ID または識別子のプロジェクトをアーカイブします。Redmine 5.0 から利用できます。

## プロジェクトのアーカイブ解除

PUT /projects/\[id\]/unarchive.xml

指定した ID または識別子のプロジェクトのアーカイブを解除します。Redmine 5.0 から利用できます。

## プロジェクトの削除

DELETE /projects/\[id\].xml

指定した ID または識別子のプロジェクトを削除します。

## 制限:

Redmine 1.0.1-2(Debian stable)では、POST リクエストは API キーでは動きませんが、ログインID/パスワードの認証では動きます\
\[#12104](https://www.redmine.org/issues/12104)
