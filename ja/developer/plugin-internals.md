---
source: Plugin_Internals
translated_from_version: 24
---

# プラグインの内部の仕組み

このページは、Redmine のプラグインの開発に関する情報をまとめる場所です。

## Redmine 本体の上書き

Redmine では、ビューは上書きできますが、コントローラーやモデルは上書きできません。架空のプラグイン `MyPlugin` でコントローラー (またはモデル) とビューを上書きしようとすると、Redmine/Rails は次のように動きます。

### コントローラー (またはモデル)

1.  Rails が起動し、フレームワークをすべて読み込みます
2.  Rails がプラグインのコードを読み込み始めます
3.  Rails が MyPlugin の `IssueController` を見つけ、`show` アクションが定義されていることを認識します
4.  Rails がほかのプラグインをすべて読み込みます
5.  Rails が *../app* からアプリケーションを読み込みます
6.  Rails が `IssueController` をもう一度見つけ、こちらにも `show` アクションが定義されていることを認識します
7.  Rails (正確には Ruby) が、プラグインの `show` アクションを *../app* のもので上書きします
8.  Rails が読み込みを終え、リクエストを処理します

### ビュー

ビューの読み込みもほとんど同じですが、小さな違いが 1 つあります (`Redmine::Plugin.register` がプラグインのビューのディレクトリを先頭に追加するためです)。

1.  Rails が起動し、フレームワークをすべて読み込みます
2.  Rails がプラグインのコードを読み込み始めます
3.  Rails が *../plugins/my_plugin/app/views* にビューのディレクトリを見つけ、ビューのパスの**先頭に追加**します
4.  Rails がほかのプラグインをすべて読み込みます
5.  Rails が *../app* からアプリケーションを読み込みます
6.  Rails が読み込みを終え、リクエストを処理します
7.  リクエストが届き、ビューをレンダリングする必要が生じます
8.  Rails が一致するテンプレートを探し、ビューのパスの**先頭に追加**されているプラグインのテンプレートを読み込みます
9.  Rails がプラグインのビューをレンダリングします

モデルとコントローラーは Ruby の方法で (モジュールを include して) 簡単に拡張できるため、Redmine は本体のモデルやコントローラーを上書きするための API を用意するべきではなく、実際に用意していません。一方、ビューは (Rails の仕組みのせいで) 扱いが難しいため、上書きのための API がはるかに役に立ちます (そのため Redmine に実装されています)。

Redmine 本体の既存のビューを上書きするには、*../app/views/* にあるものとまったく同じ名前のビューのファイルを作成するだけで、Redmine がそれを使います。たとえば、プロジェクトの一覧のページを上書きするには、*../plugins/my_plugin/app/views/projects/index.html.erb* にファイルを追加します。

## Redmine 本体の拡張

上で説明したとおり、モデルやコントローラーを上書きしたいことはまずありません。代わりに、次のどちらかにします。

- モデルやコントローラーに新しいメソッドを追加する
- 既存のメソッドをラップする

### 新しいメソッドの追加

**新しいメソッドの追加**の簡単な例が、Eric Davis の [Budget plugin](http://github.com/edavis10/redmine-budget-plugin/blob/5076b1c88b57c2068aa92cdf694769dbd22d061a/lib/issue_patch.rb) にあります。ここでは Issue に `deliverable_subject` という新しいメソッドを追加し、関連も宣言しています。

```ruby
module IssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    # Wraps the association to get the Deliverable subject.  Needed for the
    # Query and filtering
    def deliverable_subject
      unless self.deliverable.nil?
        return self.deliverable.subject
      end
    end
  end
end
```

### 既存のメソッドのラップ

<blockquote>

**注意!**\
alias_method_chain のパターンは Rails 5 で非推奨になったため、この方法は 4.0.0 より前の Redmine にしか使えません。

</blockquote>

**既存のメソッドのラップ**の簡単な例が、Eric Davis の [Rate plugin](http://github.com/edavis10/redmine_rate/blob/4666ddb10e1061ca3ef362735d0d264676b99024/lib/rate_users_helper_patch.rb) にあります。ここでは `alias_method_chain` を使って UsersHelper にフックし、`user_settings_tabs` メソッドをラップしています。そのため、Redmine 本体が `user_settings_tabs` を呼び出すと、処理は次のように進みます。

1.  Redmine 本体が `UsersHelper#user_settings_tabs` を呼び出します
2.  `UsersHelper#user_settings_tabs` が実行されます (実際には `UsersHelper#user_settings_tabs_with_rate_tab` です)
3.  `UsersHelper#user_settings_tabs_with_rate_tab` が、元の `UsersHelper#user_settings_tabs` (`UsersHelper#user_settings_tabs_without_rate_tab` に名前が変わっています) を呼び出します
4.  その結果に新しいハッシュが追加されます
5.  `UsersHelper#user_settings_tabs_with_rate_tab` が、まとめた結果を Redmine 本体に返し、それがレンダリングされます

```ruby
module RateUsersHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :user_settings_tabs, :rate_tab
    end
  end

  module InstanceMethods
    # Adds a rates tab to the user administration page
    def user_settings_tabs_with_rate_tab
      tabs = user_settings_tabs_without_rate_tab
      tabs << { :name => 'rates', :partial => 'users/rates', :label => :rate_label_rate_history}
      return tabs
    end
  end
end
```

この方法のラップは、1 つのメソッドに 1 回しかできないことに注意してください。複数のプラグインがこの方法を使うと、最後に評価された `alias_method_chain` だけが有効になり、それより前のものはすべて無視されます。

[`alias_method_chain`](http://apidock.com/rails/v3.2.13/Module/alias_method_chain) はかなり高度なメソッドですが、とても強力です。

## Redmine のプラグインで Rails のコールバックを使う

たとえば、保存・作成されるすべてのチケットにフックしたい場合は、Redmine の[フック](hooks.md)より [Rails のコールバック](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)を使うほうがよいでしょう。主な理由は、新しいチケットを作成したときには `:controller_issues_edit_before_save` フックが呼ばれないことです。\
実装の例として、Eric Davis の「Kanban plugin」を見てください。

1.  http://github.com/edavis10/redmine_kanban/blob/000cf175795c18033caa43082c4e4d0a9f989623/init.rb#L10
2.  http://github.com/edavis10/redmine_kanban/blob/000cf175795c18033caa43082c4e4d0a9f989623/lib/redmine_kanban/issue_patch.rb#L13

これで、チケットを保存するたびに (新規でも更新でも) `issue.update_kanban_from_issue` が実行されます。

新しいチケットだけにフックしたい場合は、`after_save` コールバックの代わりに `before_create` コールバックを使えます。チケットが確実に保存されてからコードを実行したい場合は、`after_create` コールバックを使うほうがよいでしょう。

## マイページへのフック

### FAQ

- 自分のブロックのドロップダウンの選択肢が翻訳されないのはなぜですか? ドロップダウンの項目の名前は、慣例として、プラグインのロケールファイルの項目から作られます。この項目は、「マイページ」のブロックのパーシャルの名前と同じ名前にする必要があります。たとえば redmine/plugins/\<myplugin_folder\>/app/views/my/blocks/\_\<myblocks_view_file_name\>.html.erb です。そのため、ロケールファイル (たとえば redmine/plugins/\<myplugin_folder\>/config/locales/en.yml) に「\<myblocks_view_file_name\>: \<put here translation for the drop down item in my blocks configuration\>」という行を追加する必要があります。

この文字列がロケールファイルにない場合は、先頭のアンダースコアと拡張子を除いたファイル名 \<myblocks_view_file_name\> を humanize した文字列が、ドロップダウンのラベルになります。

## 参考

- [Can a plugin modify the view of the projects page?](https://www.redmine.org/boards/3/topics/4283)
- [Rails Engines and extending the issue model](https://www.redmine.org/boards/3/topics/4095)
