---
source: List_of_vendored_third-party_core_components
translated_from_version: 8
---

# 同梱しているサードパーティのコンポーネント一覧

<table>
<tbody>
<tr>
<td><strong>このページは作成中です</strong>。<br />
このページの情報は、古かったり不正確だったりする可能性があることに注意してください。</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

このページでは、Redmine が依存し、Redmine と一緒に配布している、本体に同梱のサードパーティのコンポーネントを説明します。

## r21879 時点の Redmine trunk(source:/trunk@21879)

<table>
<thead>
<tr>
<th style="text-align: center;">名前</th>
<th>バージョン</th>
<th>場所<a href="#fn1" class="footnote-ref" id="fnref1" role="doc-noteref"><sup>1</sup></a></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/trunk/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn2" class="footnote-ref" id="fnref2" role="doc-noteref"><sup>2</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/rails/acts_as_tree<br />
https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/trunk/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn3" class="footnote-ref" id="fnref3" role="doc-noteref"><sup>3</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/woods/gravatar-plugin<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td>source:/trunk/lib/redmine/string_array_diff@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn4" class="footnote-ref" id="fnref4" role="doc-noteref"><sup>4</sup></a></td>
<td>{{collapse(URL (s)…)<br />
http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />
https://github.com/pmarreck/diff<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/trunk/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn5" class="footnote-ref" id="fnref5" role="doc-noteref"><sup>5</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/trunk/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td>{{collapse(URL (s)…)<br />
https://dotclear.org/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Chart.js</code></td>
<td>3.9.1</td>
<td>source:/trunk/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/chartjs/Chart.js<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td>source:/trunk/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</td>
<td>いいえ<a href="#fn6" class="footnote-ref" id="fnref6" role="doc-noteref"><sup>6</sup></a></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jquery/jquery<br />
https://github.com/jquery/jquery-ui<br />
https://rubygems.org/gems/actionview/<br />
https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />
https://github.com/rails/jquery-ujs<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/trunk/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/DmitryBaranovskiy/raphael/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/trunk/public/javascripts/tablesort-5.2.1.min.js@21879<br />
source:/trunk/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/tristen/tablesort<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/trunk/public/javascripts/tribute-5.1.3.min.js@21879<br />
source:/trunk/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/zurb/tribute<br />
}}</td>
</tr>
</tbody>
</table>
<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">
<hr />
<ol>
<li id="fn1"><p>追加の CSS、画像、i18n のアセットを除く<a href="#fnref1" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn2"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref2" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn3"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref3" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn4"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref4" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn5"><p>アップストリームはメンテナンスされていないが、書き直されたものがある<a href="#fnref5" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn6"><p>ただし、結合したファイルは手作業で作成している<a href="#fnref6" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
</ol>
</section>

## r21879 時点の Redmine 5.0-stable(source:/branches/5.0-stable@21879)

<table>
<thead>
<tr>
<th style="text-align: center;">名前</th>
<th>バージョン</th>
<th>場所<a href="#fn1" class="footnote-ref" id="fnref1" role="doc-noteref"><sup>1</sup></a></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/branches/5.0-stable/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn2" class="footnote-ref" id="fnref2" role="doc-noteref"><sup>2</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/rails/acts_as_tree<br />
https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/branches/5.0-stable/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn3" class="footnote-ref" id="fnref3" role="doc-noteref"><sup>3</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/woods/gravatar-plugin<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td>source:/branches/5.0-stable/lib/redmine/string_array_diff@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn4" class="footnote-ref" id="fnref4" role="doc-noteref"><sup>4</sup></a></td>
<td>{{collapse(URL (s)…)<br />
http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />
https://github.com/pmarreck/diff<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/branches/5.0-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn5" class="footnote-ref" id="fnref5" role="doc-noteref"><sup>5</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/branches/5.0-stable/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td>{{collapse(URL (s)…)<br />
https://dotclear.org/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Chart.js</code></td>
<td>3.9.1</td>
<td>source:/branches/5.0-stable/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/chartjs/Chart.js<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td>source:/branches/5.0-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</td>
<td>いいえ<a href="#fn6" class="footnote-ref" id="fnref6" role="doc-noteref"><sup>6</sup></a></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jquery/jquery<br />
https://github.com/jquery/jquery-ui<br />
https://rubygems.org/gems/actionview/<br />
https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />
https://github.com/rails/jquery-ujs<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/branches/5.0-stable/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/DmitryBaranovskiy/raphael/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.min.js@21879<br />
source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/tristen/tablesort<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/branches/5.0-stable/public/javascripts/tribute-5.1.3.min.js@21879<br />
source:/branches/5.0-stable/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/zurb/tribute<br />
}}</td>
</tr>
</tbody>
</table>
<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">
<hr />
<ol>
<li id="fn1"><p>追加の CSS、画像、i18n のアセットを除く<a href="#fnref1" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn2"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref2" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn3"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref3" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn4"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref4" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn5"><p>アップストリームはメンテナンスされていないが、書き直されたものがある<a href="#fnref5" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn6"><p>ただし、結合したファイルは手作業で作成している<a href="#fnref6" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
</ol>
</section>

## r21879 時点の Redmine 4.2-stable(source:/branches/4.2-stable@21879)

<table>
<thead>
<tr>
<th style="text-align: center;">名前</th>
<th>バージョン</th>
<th>場所<a href="#fn1" class="footnote-ref" id="fnref1" role="doc-noteref"><sup>1</sup></a></th>
<th>パッチ適用</th>
<th>圧縮</th>
<th>元のソースのメンテナンス</th>
<th>アップストリームのサイト</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><strong>Ruby のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td>source:/branches/4.2-stable/lib/plugins/acts_as_tree@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn2" class="footnote-ref" id="fnref2" role="doc-noteref"><sup>2</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/rails/acts_as_tree<br />
https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>gravatar</code></td>
<td>2009-09-17</td>
<td>source:/branches/4.2-stable/lib/plugins/gravatar@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn3" class="footnote-ref" id="fnref3" role="doc-noteref"><sup>3</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/woods/gravatar-plugin<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>open_id_authentication</code></td>
<td>2010-01-21</td>
<td>source:/branches/4.2-stable/lib/plugins/open_id_authentication@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn4" class="footnote-ref" id="fnref4" role="doc-noteref"><sup>4</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/rails/open_id_authentication<br />
https://github.com/Velir/open_id_authentication<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Diff</code></td>
<td>0.3</td>
<td>source:/branches/4.2-stable/lib/diff.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn5" class="footnote-ref" id="fnref5" role="doc-noteref"><sup>5</sup></a></td>
<td>{{collapse(URL (s)…)<br />
http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />
https://github.com/pmarreck/diff<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>redcloth3</code></td>
<td>3.0.4</td>
<td>source:/branches/4.2-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</td>
<td>はい</td>
<td>該当なし</td>
<td>いいえ<a href="#fn6" class="footnote-ref" id="fnref6" role="doc-noteref"><sup>6</sup></a></td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><strong>JavaScript のライブラリ</strong></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align: center;"><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td>source:/branches/4.2-stable/public/javascripts/jstoolbar@21879</td>
<td>はい</td>
<td>いいえ</td>
<td>いいえ</td>
<td>{{collapse(URL (s)…)<br />
https://dotclear.org/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Chart.js</code></td>
<td>2.8.0</td>
<td>source:/branches/4.2-stable/public/javascripts/chart.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/chartjs/Chart.js<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 5.2.8.1</td>
<td>source:/branches/4.2-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-5.2.8.1.js@21879</td>
<td>いいえ<a href="#fn7" class="footnote-ref" id="fnref7" role="doc-noteref"><sup>7</sup></a></td>
<td>はい / はい / いいえ</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/jquery/jquery<br />
https://github.com/jquery/jquery-ui<br />
https://rubygems.org/gems/actionview/<br />
https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />
https://github.com/rails/jquery-ujs<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>raphael.js</code></td>
<td>2.3.0</td>
<td>source:/branches/4.2-stable/public/javascripts/raphael.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/DmitryBaranovskiy/raphael/<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td>source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.min.js@21879<br />
source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/tristen/tablesort<br />
}}</td>
</tr>
<tr>
<td style="text-align: center;"><code>Tribute</code></td>
<td>5.1.3</td>
<td>source:/branches/4.2-stable/public/javascripts/tribute-5.1.3.min.js@21879<br />
source:/branches/4.2-stable/public/javascripts/tribute.min.js.map@21879</td>
<td>いいえ</td>
<td>はい</td>
<td>はい</td>
<td>{{collapse(URL (s)…)<br />
https://github.com/zurb/tribute<br />
}}</td>
</tr>
</tbody>
</table>
<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">
<hr />
<ol>
<li id="fn1"><p>追加の CSS、画像、i18n のアセットを除く<a href="#fnref1" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn2"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref2" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn3"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref3" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn4"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref4" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn5"><p>アップストリームはメンテナンスされていないが、フォークや後継がある<a href="#fnref5" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn6"><p>アップストリームはメンテナンスされていないが、書き直されたものがある<a href="#fnref6" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
<li id="fn7"><p>ただし、結合したファイルは手作業で作成している<a href="#fnref7" class="footnote-back" role="doc-backlink">↩︎</a></p></li>
</ol>
</section>
