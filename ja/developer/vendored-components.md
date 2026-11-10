---
source: List_of_vendored_third-party_core_components
translated_from_version: 8
---

# 同梱しているサードパーティのコンポーネント一覧

<table>
<tbody>
<tr>
<td style="background-color:#FFEBC1; color:#A6750C; padding: 4px 4px 4px 4px; border: 2px solid #FDBF3B;"><strong>このページは作成中です</strong>。<br />このページの情報は、古かったり不正確だったりする可能性があることに注意してください。</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

このページでは、Redmine が依存し、Redmine と一緒に配布している、本体に同梱のサードパーティのコンポーネントを説明します。

## r21879 時点の Redmine trunk(source:/trunk@21879)

<table>
<thead>
<tr>
<th>名前</th>
<th>バージョン</th>
<th>場所<sup>1</sup></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/trunk/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/trunk/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td>source:/trunk/lib/redmine/string_array_diff@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/trunk/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>4</sup></td>
<td><details><summary>URL...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/trunk/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td><details><summary>URL...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>3.9.1</td>
<td>source:/trunk/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td>source:/trunk/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</td>
<td>いいえ<sup>2</sup></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/trunk/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/trunk/public/javascripts/tablesort-5.2.1.min.js@21879<br />source:/trunk/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/trunk/public/javascripts/tribute-5.1.3.min.js@21879<br />source:/trunk/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

## r21879 時点の Redmine 5.0-stable(source:/branches/5.0-stable@21879)

<table>
<thead>
<tr>
<th>名前</th>
<th>バージョン</th>
<th>場所<sup>1</sup></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/branches/5.0-stable/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/branches/5.0-stable/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td>source:/branches/5.0-stable/lib/redmine/string_array_diff@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/branches/5.0-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>4</sup></td>
<td><details><summary>URL...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/branches/5.0-stable/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td><details><summary>URL...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>3.9.1</td>
<td>source:/branches/5.0-stable/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td>source:/branches/5.0-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</td>
<td>いいえ<sup>2</sup></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/branches/5.0-stable/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.min.js@21879<br />source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/branches/5.0-stable/public/javascripts/tribute-5.1.3.min.js@21879<br />source:/branches/5.0-stable/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

## r21879 時点の Redmine 4.2-stable(source:/branches/4.2-stable@21879)

<table>
<thead>
<tr>
<th>名前</th>
<th>バージョン</th>
<th>場所<sup>1</sup></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/branches/4.2-stable/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/branches/4.2-stable/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>open_id_authentication</code></td>
<td>2010-01-21</td>
<td>source:/branches/4.2-stable/lib/plugins/open_id_authentication@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>https://github.com/rails/open_id_authentication<br />https://github.com/Velir/open_id_authentication</details></td>
</tr>
<tr>
<td><code>Diff</code></td>
<td>0.3</td>
<td>source:/branches/4.2-stable/lib/diff.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>3</sup></td>
<td><details><summary>URL...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/branches/4.2-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<sup>4</sup></td>
<td><details><summary>URL...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/branches/4.2-stable/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td><details><summary>URL...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>2.8.0</td>
<td>source:/branches/4.2-stable/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 5.2.8.1</td>
<td>source:/branches/4.2-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-5.2.8.1.js@21879</td>
<td>いいえ<sup>2</sup></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/branches/4.2-stable/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.min.js@21879<br />source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/branches/4.2-stable/public/javascripts/tribute-5.1.3.min.js@21879<br />source:/branches/4.2-stable/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td><details><summary>URL...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

<sup>1</sup> 追加の CSS、画像、i18n のアセットを除く

<sup>2</sup> ただし、結合したファイルは手作業で作成している

<sup>3</sup> アップストリームはメンテナンスされていないが、フォークや後継がある

<sup>4</sup> アップストリームはメンテナンスされていないが、書き直されたものがある
