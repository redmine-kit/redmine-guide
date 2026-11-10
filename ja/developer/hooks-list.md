---
source: Hooks_List
translated_from_version: 25
---

# プラグインのフック一覧

現在のプラグインのフックの一覧を見るには、次のように Redmine のディレクトリで `call_hook` を検索します (Redmine 7.0.3 には `rake redmine:plugins:hook_list` タスクはありません)。

> [!CAUTION]
> Redmine [2.0.0](https://www.redmine.org/versions/43) 以降では、この rake タスクは非推奨になりました。\
> 代わりに、Redmine のディレクトリで次のどれかを実行できます ([hook list?](https://www.redmine.org/boards/4/topics/36062) を参照)。
>
> ```text
> grep -r call_hook *                                       # list of source lines with hook calls
> grep -rohT 'call_hook([^)]*)'                             # list of hooks calls and source files
> grep -roh  'call_hook([^)]*)' | sort -u | grep '([^)]*)'  # list of hooks calls only
> ```

## コントローラーのフック

| 名前 | 説明 | コンテキスト |
|----|----|----|
| `:controller_account_success_authentication_after` |  | `:user` |
| `:controller_custom_fields_new_after_save` |  | `:params, :custom_field` |
| `:controller_custom_fields_edit_after_save` |  | `:params, :custom_field` |
| `:controller_issues_bulk_edit_before_save` | 保存する前に、現在のチケットとパラメーターをフックに渡します。チケットの属性を設定するのに使えます。 | `:params, :issue` |
| `:controller_issues_new_before_save` |  | `:params, :issue` |
| `:controller_issues_new_after_save` |  | `:params, :issue` |
| `:controller_issues_edit_before_save` |  | `:params, :issue, :time_entry, :journal` |
| `:controller_issues_edit_after_save` |  | `:params, :issue, :time_entry, :journal` |
| `:controller_journals_edit_post` |  | `:params, :journal` |
| `:controller_messages_new_after_save` |  | `:params, :message` |
| `:controller_messages_reply_after_save` |  | `:params, :message` |
| `:controller_time_entries_bulk_edit_before_save` |  | `:params, :time_entry` |
| `:controller_timelog_edit_before_save` |  | `:params, :time_entry` |
| `:controller_wiki_edit_after_save` |  | `:params, :page` |
| `:controller_wiki_show_before_render` |  | `:content, :format` |

## ヘルパーのフック

| 名前 | 説明 | コンテキスト |
|----|----|----|
| `:helper_issues_show_detail_after_setting` | ラベルと値を設定できるように、データをフックに渡します。 | `:detail, :label, :value, :old_value` |
| `:helper_queries_column_content` |  | `:content, :column, :item` |
| `:helper_queries_column_value` |  | `:content, :column, :item, :value` |

## モデルのフック

| 名前 | 説明 | コンテキスト |
|----|----|----|
| `:model_changeset_scan_commit_for_issue_ids_pre_issue_update` |  | `:changeset, :issue, :action` |
| `:model_project_copy_before_save` |  | `:source_project, :destination_project` |

## ビューのフック

どのビューのフックでも、現在のプロジェクトはコンテキストの `:project` キーで取得できます。

| 名前 | 説明 | コンテキスト |
|----|----|----|
| `:view_account_left_bottom` |  | `:user` |
| `:view_account_right_bottom` |  | `:user` |
| `:view_account_login_top` |  | (なし) |
| `:view_account_login_bottom` |  | (なし) |
| `:view_admin_projects_sidebar_queries_bottom` |  | (なし) |
| `:view_calendars_show_bottom` |  | `:year, :month, :project, :query` |
| `:view_custom_fields_form_upper_box` |  | `:custom_field, :form` |
| `:"view_custom_fields_form_#{@custom_field.type.to_s.underscore}"` |  | `:custom_field, :form` |
| `:view_issue_statuses_form` |  | `:issue_status` |
| `:view_groups_memberships_table_header` |  | `:group` |
| `:view_groups_memberships_table_row` |  | `:group, :membership` |
| `:view_issues_bulk_edit_details_bottom` | 一括編集のフォームの、コメントの前に内容を追加します | `:issues` |
| `:view_issues_edit_top` | チケットの編集フォームの先頭に内容を追加します | `:issue, :form` |
| `:view_issues_edit_notes_bottom` | コメントの下、ファイルのフォームの前に内容を追加します | `:issue, :notes, :form` |
| `:view_issues_form_details_top` | チケットのフォームの先頭に内容を追加します | `:issue, :form` |
| `:view_issues_form_details_bottom` | チケットのフォームの下部にある HTML のテーブルに内容を追加します | `:issue, :form` |
| `:view_issues_history_journal_bottom` |  | `:journal` |
| `:view_issues_history_changeset_bottom` |  | `:changeset` |
| `:view_issues_history_time_entry_bottom` |  | `:time_entry` |
| `:view_issues_index_bottom` |  | `:issues, :project, :query` |
| `:view_issues_show_details_bottom` | チケットの詳細のテーブルの下部に内容を追加します | `:issue` |
| `:view_issues_sidebar_issues_bottom` |  | (なし) |
| `:view_issues_sidebar_planning_bottom` |  | (なし) |
| `:view_issues_sidebar_queries_bottom` |  | (なし) |
| `:view_issues_context_menu_start` |  | `:issues, :can, :back` |
| `:view_issues_context_menu_end` |  | `:issues, :can, :back` |
| `:view_issues_new_top` |  | `:issue` |
| `:view_issues_show_description_bottom` |  | `:issue` |
| `:view_journals_notes_form_after_notes` |  | `:journal` |
| `:view_journals_update_js_bottom` |  | `:journal` |
| `:view_layouts_base_body_bottom` | 基本のレイアウトの body の末尾に内容を追加します | (なし) |
| `:view_layouts_base_body_top` | 基本のレイアウトの body の先頭に内容を追加します | (なし) |
| `:view_layouts_base_content` |  | (なし) |
| `:view_layouts_base_html_head` | 基本のレイアウトの HTML の head に内容を追加します | (なし) |
| `:view_layouts_base_sidebar` |  | (なし) |
| `:view_my_account` |  | `:user, :form` |
| `:view_my_account_contextual` |  | `:user` |
| `:view_my_account_preferences` |  | `:user, :form` |
| `:view_my_page_contextual` |  | `:user` |
| `:view_my_page_splitcontent` |  | `:user` |
| `:view_projects_form` |  | `:project, :form` |
| `:view_projects_copy_only_items` |  | `:project, :f` |
| `:view_projects_roadmap_version_bottom` |  | `:version` |
| `:view_projects_settings_members_table_header` | プロジェクトの「メンバー」の設定のテーブルのヘッダーに内容を追加します | `:project` |
| `:view_projects_settings_members_table_row` | プロジェクトの「メンバー」の設定のテーブルの行に内容を追加します | `:member, :project` |
| `:view_projects_show_left` |  | `:project` |
| `:view_projects_show_right` |  | `:project` |
| `:view_projects_show_sidebar_bottom` |  | `:project` |
| `:view_projects_sidebar_queries_bottom` |  | (なし) |
| `:view_reports_issue_report_split_content_left` |  | `:project` |
| `:view_reports_issue_report_split_content_right` |  | `:project` |
| `:view_repositories_show_contextual` | リポジトリの画面のコンテキストメニューに内容を追加します | `:project, :repository` |
| `:view_search_index_options_content_bottom` |  | (なし) |
| `:view_timelog_edit_form_bottom` |  | `:time_entry, :form` |
| `:view_time_entries_bulk_edit_details_bottom` |  | `:time_entries` |
| `:view_time_entries_context_menu_start` |  | `:time_entries, :can, :back` |
| `:view_time_entries_context_menu_end` |  | `:time_entries, :can, :back` |
| `:view_settings_general_form` |  | (なし) |
| `:view_users_memberships_table_header` |  | `:user` |
| `:view_users_memberships_table_row` |  | `:user, :membership` |
| `:view_users_form` |  | `:user, :form` |
| `:view_users_form_preferences` |  | `:user, :form` |
| `:view_users_sidebar_queries_bottom` |  | (なし) |
| `:view_versions_show_bottom` |  | `:version` |
| `:view_versions_show_contextual` |  | `:version, :project` |
| `:view_welcome_index_left` |  | `:project` |
| `:view_welcome_index_right` |  | `:project` |
| `:view_wiki_show_sidebar_bottom` |  | `:wiki, :page` |

## そのほかのフック

| 名前 | 説明 | コンテキスト |
|------|-------------|---------|
| `:after_plugins_loaded` | すべてのプラグインの `init.rb` を読み込んだ後に呼び出されます | (なし) |
