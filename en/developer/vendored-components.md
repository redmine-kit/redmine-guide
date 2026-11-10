---
source: List_of_vendored_third-party_core_components
source_url: https://www.redmine.org/projects/redmine/wiki/List_of_vendored_third-party_core_components
source_version: 8
source_updated_on: '2022-10-02T07:03:02Z'
updated_for: 7.0.3
---

# List of vendored third-party core components

> [!WARNING] This page is a WIP
> Please be aware that the information provided on this page may be out of date, or otherwise inaccurate.

------------------------------------------------------------------------

This page aims at documenting the vendored third-party core components depended upon by and distributed along with Redmine.

## Redmine 7.0.3 ([source:/tags/7.0.3](https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3))

<table>
<thead>
<tr>
<th>Name</th>
<th>Version</th>
<th>Location<sup>1</sup></th>
<th>Patched</th>
<th>Minified</th>
<th>Original source maintained</th>
<th>Upstream site(s)</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby libraries</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/lib/plugins/acts_as_tree">source:/tags/7.0.3/lib/plugins/acts_as_tree</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/lib/plugins/gravatar">source:/tags/7.0.3/lib/plugins/gravatar</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/lib/redmine/string_array_diff">source:/tags/7.0.3/lib/redmine/string_array_diff</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/lib/redmine/wiki_formatting/textile/redcloth3.rb">source:/tags/7.0.3/lib/redmine/wiki_formatting/textile/redcloth3.rb</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>4</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript libraries</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/app/assets/javascripts/jstoolbar">source:/tags/7.0.3/app/assets/javascripts/jstoolbar</a></td>
<td>Yes</td>
<td>No</td>
<td>No</td>
<td><details><summary>URL(s)...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>4.5.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/vendor/javascript/chart.min.js">source:/tags/7.0.3/vendor/javascript/chart.min.js</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code></td>
<td>3.7.1 / 1.13.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/app/assets/javascripts/jquery-3.7.1-ui-1.13.3.js">source:/tags/7.0.3/app/assets/javascripts/jquery-3.7.1-ui-1.13.3.js</a></td>
<td>No<sup>2</sup></td>
<td>Yes / Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.7.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/vendor/javascript/tablesort.min.js">source:/tags/7.0.3/vendor/javascript/tablesort.min.js</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/vendor/javascript/tablesort.number.min.js">source:/tags/7.0.3/vendor/javascript/tablesort.number.min.js</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/app/assets/javascripts/tribute-5.1.3.min.js">source:/tags/7.0.3/app/assets/javascripts/tribute-5.1.3.min.js</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/app/assets/javascripts/tribute.min.js.map">source:/tags/7.0.3/app/assets/javascripts/tribute.min.js.map</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/zurb/tribute</details></td>
</tr>
<tr>
<td><code>Turndown</code></td>
<td>7.2.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/tags/7.0.3/vendor/javascript/turndown.js">source:/tags/7.0.3/vendor/javascript/turndown.js</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/mixmark-io/turndown</details></td>
</tr>
</tbody>
</table>

In Redmine 7.0.3, `rails-ujs` is no longer combined with jQuery: it is loaded from Rails (actionview). Raphael.js was removed in Redmine 7.0.0. The license files of the bundled third-party components are in `doc/licenses`.

## Redmine trunk at [r21879](https://www.redmine.org/projects/redmine/repository/svn/revisions/21879) ([source:/trunk@21879](https://www.redmine.org/projects/redmine/repository/svn/show/trunk?rev=21879))

<table>
<thead>
<tr>
<th>Name</th>
<th>Version</th>
<th>Location<sup>1</sup></th>
<th>Patched</th>
<th>Minified</th>
<th>Original source maintained</th>
<th>Upstream site(s)</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby libraries</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/plugins/acts_as_tree?rev=21879">source:/trunk/lib/plugins/acts_as_tree@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/plugins/gravatar?rev=21879">source:/trunk/lib/plugins/gravatar@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/redmine/string_array_diff?rev=21879">source:/trunk/lib/redmine/string_array_diff@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/lib/redmine/wiki_formatting/textile/redcloth3.rb?rev=21879">source:/trunk/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>4</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript libraries</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/jstoolbar?rev=21879">source:/trunk/public/javascripts/jstoolbar@21879</a></td>
<td>Yes</td>
<td>No</td>
<td>No</td>
<td><details><summary>URL(s)...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>3.9.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/chart.min.js?rev=21879">source:/trunk/public/javascripts/chart.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js?rev=21879">source:/trunk/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</a></td>
<td>No<sup>2</sup></td>
<td>Yes / Yes / No</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/raphael.js?rev=21879">source:/trunk/public/javascripts/raphael.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/tablesort-5.2.1.min.js?rev=21879">source:/trunk/public/javascripts/tablesort-5.2.1.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/tablesort-5.2.1.number.min.js?rev=21879">source:/trunk/public/javascripts/tablesort-5.2.1.number.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/tribute-5.1.3.min.js?rev=21879">source:/trunk/public/javascripts/tribute-5.1.3.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/trunk/public/javascripts/tribute.min.js.map?rev=21879">source:/trunk/public/javascripts/tribute.min.js.map@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

## Redmine 5.0-stable at [r21879](https://www.redmine.org/projects/redmine/repository/svn/revisions/21879) ([source:/branches/5.0-stable@21879](https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable?rev=21879))

<table>
<thead>
<tr>
<th>Name</th>
<th>Version</th>
<th>Location<sup>1</sup></th>
<th>Patched</th>
<th>Minified</th>
<th>Original source maintained</th>
<th>Upstream site(s)</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby libraries</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/lib/plugins/acts_as_tree?rev=21879">source:/branches/5.0-stable/lib/plugins/acts_as_tree@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/lib/plugins/gravatar?rev=21879">source:/branches/5.0-stable/lib/plugins/gravatar@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>Diff</code> [<code>string_array_diff</code>]</td>
<td>0.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/lib/redmine/string_array_diff?rev=21879">source:/branches/5.0-stable/lib/redmine/string_array_diff@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb?rev=21879">source:/branches/5.0-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>4</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript libraries</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/jstoolbar?rev=21879">source:/branches/5.0-stable/public/javascripts/jstoolbar@21879</a></td>
<td>Yes</td>
<td>No</td>
<td>No</td>
<td><details><summary>URL(s)...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>3.9.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/chart.min.js?rev=21879">source:/branches/5.0-stable/public/javascripts/chart.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 6.1.7</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js?rev=21879">source:/branches/5.0-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-6.1.7.js@21879</a></td>
<td>No<sup>2</sup></td>
<td>Yes / Yes / No</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/raphael.js?rev=21879">source:/branches/5.0-stable/public/javascripts/raphael.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/tablesort-5.2.1.min.js?rev=21879">source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/tablesort-5.2.1.number.min.js?rev=21879">source:/branches/5.0-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/tribute-5.1.3.min.js?rev=21879">source:/branches/5.0-stable/public/javascripts/tribute-5.1.3.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/5.0-stable/public/javascripts/tribute.min.js.map?rev=21879">source:/branches/5.0-stable/public/javascripts/tribute.min.js.map@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

## Redmine 4.2-stable at [r21879](https://www.redmine.org/projects/redmine/repository/svn/revisions/21879) ([source:/branches/4.2-stable@21879](https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable?rev=21879))

<table>
<thead>
<tr>
<th>Name</th>
<th>Version</th>
<th>Location<sup>1</sup></th>
<th>Patched</th>
<th>Minified</th>
<th>Original source maintained</th>
<th>Upstream site(s)</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="7" style="text-align: center;"><strong>Ruby libraries</strong></td>
</tr>
<tr>
<td><code>acts_as_tree</code></td>
<td>2007-09-11</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/lib/plugins/acts_as_tree?rev=21879">source:/branches/4.2-stable/lib/plugins/acts_as_tree@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/rails/acts_as_tree<br />https://github.com/amerine/acts_as_tree (https://rubygems.org/gems/acts_as_tree)</details></td>
</tr>
<tr>
<td><code>gravatar</code></td>
<td>2009-09-17</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/lib/plugins/gravatar?rev=21879">source:/branches/4.2-stable/lib/plugins/gravatar@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/woods/gravatar-plugin</details></td>
</tr>
<tr>
<td><code>open_id_authentication</code></td>
<td>2010-01-21</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/lib/plugins/open_id_authentication?rev=21879">source:/branches/4.2-stable/lib/plugins/open_id_authentication@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/rails/open_id_authentication<br />https://github.com/Velir/open_id_authentication</details></td>
</tr>
<tr>
<td><code>Diff</code></td>
<td>0.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/lib/diff.rb?rev=21879">source:/branches/4.2-stable/lib/diff.rb@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>3</sup></td>
<td><details><summary>URL(s)...</summary>http://web.archive.org/web/20140421214841/http://users.cybercity.dk/~dsl8950/ruby/diff.html<br />https://github.com/pmarreck/diff</details></td>
</tr>
<tr>
<td><code>redcloth3</code></td>
<td>3.0.4</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb?rev=21879">source:/branches/4.2-stable/lib/redmine/wiki_formatting/textile/redcloth3.rb@21879</a></td>
<td>Yes</td>
<td>n/a</td>
<td>No<sup>4</sup></td>
<td><details><summary>URL(s)...</summary>https://github.com/jgarber/redcloth (https://rubygems.org/gems/RedCloth)</details></td>
</tr>
<tr>
<td colspan="7" style="text-align: center;"><strong>JavaScript libraries</strong></td>
</tr>
<tr>
<td><code>jstoolbar</code></td>
<td>&lt;= 2006-11-05</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/jstoolbar?rev=21879">source:/branches/4.2-stable/public/javascripts/jstoolbar@21879</a></td>
<td>Yes</td>
<td>No</td>
<td>No</td>
<td><details><summary>URL(s)...</summary>https://dotclear.org/</details></td>
</tr>
<tr>
<td><code>Chart.js</code></td>
<td>2.8.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/chart.min.js?rev=21879">source:/branches/4.2-stable/public/javascripts/chart.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/chartjs/Chart.js</details></td>
</tr>
<tr>
<td><code>jQuery</code> / <code>jQuery-UI</code> / <code>jQuery-UJS</code></td>
<td>3.6.1 / 1.13.2 / 5.2.8.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-5.2.8.1.js?rev=21879">source:/branches/4.2-stable/public/javascripts/jquery-3.6.1-ui-1.13.2-ujs-5.2.8.1.js@21879</a></td>
<td>No<sup>2</sup></td>
<td>Yes / Yes / No</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/jquery/jquery<br />https://github.com/jquery/jquery-ui<br />https://rubygems.org/gems/actionview/<br />https://github.com/rails/rails/tree/main/actionview/app/assets/javascripts<br />https://github.com/rails/jquery-ujs</details></td>
</tr>
<tr>
<td><code>raphael.js</code></td>
<td>2.3.0</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/raphael.js?rev=21879">source:/branches/4.2-stable/public/javascripts/raphael.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/DmitryBaranovskiy/raphael/</details></td>
</tr>
<tr>
<td><code>tablesort</code> / <code>tablesort-number</code></td>
<td>5.2.1</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/tablesort-5.2.1.min.js?rev=21879">source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/tablesort-5.2.1.number.min.js?rev=21879">source:/branches/4.2-stable/public/javascripts/tablesort-5.2.1.number.min.js@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/tristen/tablesort</details></td>
</tr>
<tr>
<td><code>Tribute</code></td>
<td>5.1.3</td>
<td><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/tribute-5.1.3.min.js?rev=21879">source:/branches/4.2-stable/public/javascripts/tribute-5.1.3.min.js@21879</a><br /><a href="https://www.redmine.org/projects/redmine/repository/svn/show/branches/4.2-stable/public/javascripts/tribute.min.js.map?rev=21879">source:/branches/4.2-stable/public/javascripts/tribute.min.js.map@21879</a></td>
<td>No</td>
<td>Yes</td>
<td>Yes</td>
<td><details><summary>URL(s)...</summary>https://github.com/zurb/tribute</details></td>
</tr>
</tbody>
</table>

<sup>1</sup> excluding additional CSS, image and i18n assets

<sup>2</sup> the combined file is produced manually though

<sup>3</sup> upstream is not maintained, but upstream forks/continuations exists

<sup>4</sup> upstream is not maintained, but upstream rewrites exists
