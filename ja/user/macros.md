---
source: RedmineMacros
translated_from_version: 3
---

# マクロ

Redmine にはマクロの仕組みがあり、書式付きテキストに動的な内容を挿入する独自の機能を追加できます。

## 書式付きテキストでのマクロの呼び出し

マクロは二重の波かっこで呼び出します。引数がある場合は、丸かっこで囲みます。マクロ名または引数のあとで改行すると、そこから先がマクロに渡すテキストのブロックになります(テキストのブロックを受け付けないマクロにテキストを付けて呼び出すと、失敗します)。

例:

    引数なし:
    {{my_macro}}

    引数あり:
    {{my_macro(arg1, arg2)}}

    テキストのブロックあり:
    {{my_macro
    multiple lines
    of text
    }}

    引数とテキストのブロックあり
    {{my_macro(arg1, arg2)
    multiple lines
    of text
    }}

テキストのブロックを渡す場合は、閉じタグ `}}` を新しい行の先頭に置く必要があります。

## カスタムマクロの追加

カスタムマクロは、Redmine のプラグインから次の構文で追加できます。

```ruby
Redmine::WikiFormatting::Macros.macro(name, options={}, &block)
```

オプション:

- `:desc` - マクロの説明
- `:parse_args => false` - 引数の解析を無効にします(引数の文字列全体がそのままマクロに渡されます)

マクロのブロックは、2 つまたは 3 つの引数を受け取ります。

- `obj` - 表示するオブジェクト(Issue、WikiContent など)
- `args` - マクロの引数
- `text` - マクロに渡されたテキストのブロック(マクロがテキストのブロックを受け付ける場合にだけ指定します)。text は String です。テキストのブロックなしでマクロを呼び出した場合は nil になります。

ブロックは、書式付きテキストでマクロが呼び出されるたびに呼ばれ、その戻り値が最終的な出力に挿入されます。戻り値は、HTML エスケープした文字列でなければなりません。

例:

デフォルトでは、マクロを呼び出すと、コンマ区切りの引数の一覧が分割され、配列としてマクロのブロックに渡されます。引数がない場合は、空の配列でマクロが呼び出されます。

```ruby
macro :my_macro, :desc => 'This is a custom macro' do |obj, args|
  # args は配列
  # このマクロはテキストのブロックを受け付けない
end
```

`:parse_args => false` オプションで、引数の分割を無効にできます。この場合は、引数の文字列全体がマクロに渡されます。

```ruby
macro :my_macro, :parse_args => false do |obj, args|
  # args は文字列
end
```

マクロは、3 つ目の引数としてテキストのブロックを受け取ることもできます。

```ruby
macro :my_macro do |obj, args, text|
  # このマクロはテキストのブロックを受け付ける
  # text はマクロに渡されたテキスト全体を表す String
end
```

独自のマクロを書き始めるときは、組み込みのマクロの定義を参考にしてください: source:/tags/2.1.0/lib/redmine/wiki_formatting/macros.rb#L162
