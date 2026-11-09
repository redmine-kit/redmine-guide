---
source: Hooks
translated_from_version: 14
---

# プラグインのフック

Redmine はフックの考え方を取り入れています。フックは、外部のコードが Redmine 本体の機能をきれいに拡張するための API です。プラグインの作者はフックにコールバック関数を登録でき、Redmine のコードの特定の箇所に処理が来ると、登録した関数が順に実行されます。

[使えるフックの一覧](hooks-list.md)があります。ただし、フックを探すいちばんの方法は、コードを読んで拡張したい場所を見つけ、その近くでフックを呼び出している箇所を探すことです。

Redmine のコードを拡張・置き換えるほかの方法には、次のものがあります。

- [新しいメソッドの追加](plugin-internals.md#Adding-a-new-method)
- [Rails のコールバックの利用](plugin-internals.md#Using-Rails-callbacks-in-Redmine-plugins)
- `alias_method_chain` による[既存のメソッドのラップ](plugin-internals.md#Wrapping-an-existing-method)

## 基本

前に述べたとおり、フックが呼び出されると、あらかじめ登録したコールバック関数が実行されます。これらの関数は、コンテキストを表すハッシュを 1 つだけ引数に取る必要があります。このコンテキストのハッシュには、コールバック関数で役に立つ処理をするのに必要なデータが必ず入っています。コントローラーとビューのフック(後述)では、少なくとも次の情報が入っています。

- :controller =\> 現在のコントローラーのインスタンスへの参照
- :project =\> 現在のプロジェクト(コントローラーが設定している場合)
- :request =\> 現在の Web リクエストの情報を多く持つ、現在の[リクエストオブジェクト](http://api.rubyonrails.org/classes/ActionController/Request.html)

さらに、ハッシュにはそれぞれのフックに固有のデータが入ります。このデータは、Redmine のコードにある `call_hook` の呼び出しでそのまま渡されます。

モデルのフックには、これらのデフォルトのデータは入りません。モデルには当てはまらないためです。モデルのフックに入るのは、`call_hook` の呼び出しで渡されたデータだけです。

## フックの種類

現在、フックには大きく分けて 3 つの種類があります。

- ビューのフック
- コントローラーのフック
- モデルのフック

どの種類もまったく同じ API を使いますが、用途は根本的に異なります。

### ビューのフック

ビューのフックは、ビューの HTML をレンダリングする途中で実行されます。プラグインの作者は、ビューの適切な箇所に独自の HTML を挿入できます。コールバック関数の戻り値は文字列に変換され、ビューに挿入されます。パーシャルを 1 つレンダリングするための簡単な書き方もあります。例は後述します。

### コントローラーのフック

コントローラーのフックは、ビューのフックより少数です。コントローラーのアクションは短く、多くの処理をしないはずで(実際ほとんどがそうなっています)、[フィルターの追加](http://apidock.com/rails/ActionController/Filters/ClassMethods)やモデルのクラスの拡張で足りることが多いためです。ただし、長めのアクションの中にはフックを使うものもあります。それらを正しく使うには、コンテキストのハッシュにあるオブジェクトは参照されているだけだということを理解しておく必要があります。つまり、オブジェクトをその場で変更すると、変更は実際のコントローラーに(そして後でビューにも)反映されます。次の簡単な例で考えてみます。

次の関数が `do_something` フックに登録されているとします。登録の方法は後述します。

```ruby
def do_something(context={ })
  context[:issue].subject = "Nothing to fix"
end
```

コントローラーのアクションに、次のコードがあるとします。

```ruby
issue = Issue.find(1)
# issue.subject is "Fix me"
call_hook(:do_something, :issue => issue)
# issue.subject is now "Nothing to fix"
```

このように、フックの関数は `issue` オブジェクトをその場で変更できます。ただし、オブジェクトを丸ごと置き換えることはできません。オブジェクトの参照が壊れるためです。

### モデルのフック

Redmine のモデルのフックはごくわずかです。モデルのコードの拡張は、ほとんどの場合、新しいメソッドを追加するか、[alias_method_chain](plugin-internals.md#Wrapping-an-existing-method) のパターンを工夫して既存のメソッドを包み込むことで実現できます。モデルのフックは、コントローラーのフックと同じように使えます。

## フックへの関数の登録

### ビューのフック

次の例では、`view_issues_form_details_bottom` フックに関数を登録します。これを使うと、チケットの編集フォームにフィールドを追加できます。

1.  プラグイン(名前は `my_plugin` とします)の `lib/my_plugin/hooks.rb` に、次のクラスを作成します。1 つのクラスで複数のフックに登録できます。

    ```ruby
    module MyPlugin
      class Hooks < Redmine::Hook::ViewListener
        # This just renders the partial in
        # app/views/hooks/my_plugin/_view_issues_form_details_bottom.rhtml
        # The contents of the context hash is made available as local variables to the partial.
        #
        # Additional context fields
        #   :issue  => the issue this is edited
        #   :f      => the form object to create additional fields
        render_on :view_issues_form_details_bottom,
                  :partial => 'hooks/my_plugin/view_issues_form_details_bottom'
      end
    end
    ```

    次のクラスは上とまったく同じ動作をしますが、短く書ける `render_on` ヘルパーではなく、メソッドを使っています。メソッドの名前で、どのコールバックに登録するかが決まります。

    ```ruby
    module MyPlugin
      class Hooks < Redmine::Hook::ViewListener
        def view_issues_form_details_bottom(context={ })
          # the controller parameter is part of the current params object
          # This will render the partial into a string and return it.
          context[:controller].send(:render_to_string, {
            :partial => "hooks/my_plugin/view_issues_form_details_bottom",
            :locals => context
          })

          # Instead of the above statement, you could return any string generated
          # by your code. That string will be included into the view
        end
      end
    end
    ```
2.  `init.rb` で、フックのファイルを必ず require します。次のようになります。

    ```ruby
    require 'redmine'

    # This is the important line.
    # It requires the file in lib/my_plugin/hooks.rb
    require_dependency 'my_plugin/hooks'

    Redmine::Plugin.register :my_plugin do
      [...]
    end
    ```

### コントローラーとモデルのフック

コントローラーとモデルのフックにも、ビューのフックと同じようにメソッドを登録できます。フックのクラスを `init.rb` で require するのを忘れないでください。例を示します。

```ruby
module MyPlugin
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_bulk_edit_before_save(context={ })
      # set my_attribute on the issue to a default value if not set explictly
      context[:issue].my_attribute ||= "default"
    end
  end
end
```

## そのほかの例

実際に使われている例を、次の場所で見られます。

ビューのフック

- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/view_layouts_base_html_head_hook.rb
- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/view_issues_show_details_bottom_hook.rb
- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/view_issues_form_details_bottom_hook.rb
- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/view_issues_bulk_edit_details_bottom_hook.rb

ヘルパーのフック

- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/helper_issues_show_detail_after_setting_hook.rb

コントローラーのフック

- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/controller_timelog_available_criterias_hook.rb
- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/controller_issues_edit_before_save_hook.rb
- http://github.com/edavis10/redmine_contracts/blob/master/lib/redmine_contracts/hooks/controller_issues_bulk_edit_before_save_hook.rb

## TODO

- 既存のコントローラーにフィルターを追加する方法
- alias_method_chain でメソッドを上書きする方法
  - インスタンスメソッド
  - クラスメソッド
  - initialize
  - モジュール
