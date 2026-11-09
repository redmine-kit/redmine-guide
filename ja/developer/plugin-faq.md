---
source: Plugin_FAQ
translated_from_version: 8
---

# プラグインのよくある質問

このページでは、Redmine のプラグインで簡単なことを実現する方法を説明します。

## モジュールが有効か判定する

プロジェクトが `@project` 変数にある場合:

```ruby
if @project.module_enabled?("<module_name>")
```

まず、*モジュール*はプロジェクト単位の概念です。そのため、この判定はプロジェクト単位で動くアクションの中で行ってください。Redmine 本体は通常、標準のアクションで現在のプロジェクトを見つけるために `find_project` という `before_filter` を使い、これが `@project` 変数を設定します。

Redmine 2.3.x の時点で使えるモジュールは、boards、calendar、documents、files、gantt、issue_tracking、news、repository、time_tracking、wiki です。プラグインはそれぞれ独自のモジュールを追加できます(「polls」モジュールを追加する[プラグインのチュートリアル](plugin-tutorial.md)を参照してください)。

## ページのレイアウトを変える

ページのレイアウトは、そのビューを上書きして変えます。Redmine のビューは `app/views/` にあります。プラグインでページのビューを変えるには、まずビューを `app/views/` から `plugins/your_plugin/app/views/` にコピーし、そのファイルを変更します。

複数のプラグインが同じビューを上書きした場合は、最後に読み込まれたプラグインのビューが表示されます。どのビューを上書きすればよいかわからない場合は、`config/routes.rb` で、変えたいページの URL に合うパターンを探してください。手がかりになるかもしれません。

## Redmine のアプリケーションの設定値を取得する

Redmine は、アプリケーションの設定値を `config/configuration.yml` というファイルに保存しています。プラグインからこれらの設定値を取得するために、Redmine は `Redmine::Configuration` のクラスメソッドとして、ゲッターメソッド `[]` を用意しています。

例[^1]:

次の設定があるとします。

```yaml
email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: "myaddress.com"
      port: 25
      domain: "mydomain.com"
```

このとき、設定のキー `address` の値は、次のように呼び出して取得できます。

```ruby
Redmine::Configuration['email_delivery']['smtp_settings'][:address]
```

## Redmine の設定値を取得する

Redmine は、アプリケーションの設定値をデータベースに保存しています。プラグインの設定もここに含まれます。プラグインからこれらの設定値を取得・設定できるように、Redmine は `Setting` モデルの設定ごとに、`Setting.some_setting_name` と `Setting.some_setting_name = "some value"` という形のゲッターメソッドとセッターメソッドを自動で用意しています。

例:

- Redmine 本体の設定「ウェルカムメッセージ」の値は、次のように呼び出して取得します。

  ```ruby
  Setting.welcome_text
  ```
- [プラグインのチュートリアル](plugin-tutorial.md)で説明している Polls プラグインが「提供する」設定「notification_default」の値は、次のように呼び出して取得します。

  ```ruby
  Setting.plugin_polls['notification_default']
  ```

プラグインから設定値を手動で変更(設定)することはお勧めしません。代わりに、用意されている画面で設定してください。

## 特定のバージョンの Redmine を必須にする

プラグインが Redmine 本体の特定の機能を必要としたり、特定のビューを上書きしたりする場合は、必要な本体があることを保証するために、プラグインをインストールできる Redmine の(特定の)バージョンを制限する必要があります。そうすることで、プラグインの互換性に関する多くの問題を防げます。

これは `requires_redmine` メソッドで実現できます(source:/trunk/lib/redmine/plugin.rb@19983#L227 を参照)。このメソッドを使うと、特定のバージョンの Redmine を必要とするプラグインを、簡単かつ確実に作成できます。バージョンの要件を満たさない場合は、対応していないバージョンであることをメッセージで示して Redmine を停止します。

注: `requires_redmine` には、*ブランチの接尾辞*(`stable`/`devel`)の付いた Redmine のバージョン番号を渡さないでください。対応していません。これについての議論は \[#35345](https://www.redmine.org/issues/35345) を参照してください。

{{collapse(View usage examples for requires_redmine method…)

```ruby
# Requires Redmine 0.7.3 or higher
requires_redmine :version_or_higher => '0.7.3'
requires_redmine '0.7.3'

# Requires Redmine 0.7.x or higher
requires_redmine '0.7'

# Requires a specific Redmine version
requires_redmine :version => '0.7.3'              # 0.7.3 only
requires_redmine :version => '0.7'                # 0.7.x
requires_redmine :version => ['0.7.3', '0.8.0']   # 0.7.3 or 0.8.0

# Requires a Redmine version within a range
requires_redmine :version => '0.7.3'..'0.9.1'     # >= 0.7.3 and <= 0.9.1
requires_redmine :version => '0.7'..'0.9'         # >= 0.7.x and <= 0.9.x
```

\
}}

## 特定のバージョンの Redmine プラグインを必須にする

プラグインが、ほかの Redmine プラグインの特定の機能や、ほかのプラグインの特定のバージョンにある機能を必要とする場合は、必要なプラグイン(のバージョン)があることを保証するために、インストールの前に依存関係を制御する必要があります。そうすることで、プラグイン間の互換性に関する多くの問題を防げます。

これは `requires_redmine_plugin` メソッドで実現できます(source:/trunk/lib/redmine/plugin.rb@19983#L274 を参照)。このメソッドを使うと、特定の Redmine プラグイン(の特定のバージョン)を必要とするプラグインを、簡単かつ確実に作成できます。バージョンの要件を満たさない場合は、対応していないバージョンであることをメッセージで示して Redmine を停止します。

{{collapse(View usage examples for requires_redmine_plugin method…)

```ruby
# Requires a plugin named :foo version 0.7.3 or higher
requires_redmine_plugin :foo, :version_or_higher => '0.7.3'
requires_redmine_plugin :foo, '0.7.3'

# Requires a specific version of a Redmine plugin
requires_redmine_plugin :foo, :version => '0.7.3'              # 0.7.3 only
requires_redmine_plugin :foo, :version => ['0.7.3', '0.8.0']   # 0.7.3 or 0.8.0
```

\
}}

[^1]: 出典: message#59809
