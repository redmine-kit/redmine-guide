---
source: Hooks_List
source_url: https://www.redmine.org/projects/redmine/wiki/Hooks_List
source_version: 25
source_updated_on: '2021-05-27T23:53:07Z'
updated_for: 7.0.3
---

# Redmine plugin hooks list

To see the current list of plugin hooks, search for `call_hook` in the Redmine directory as shown below (the `rake redmine:plugins:hook_list` task no longer exists in Redmine 7.0.3).

<table>
<tbody>
<tr>
<td style="background-color:#f88;">On Redmine version#43 and up the rake task has been deprecated.<br />As an alternative you can use either of the following in the Redmine directory (see message#36062).<br /><pre><code>grep -r call_hook *                                       # list of source lines with hook calls
grep -rohT &#39;call_hook([^)]*)&#39;                             # list of hooks calls and source files
grep -roh  &#39;call_hook([^)]*)&#39; | sort -u | grep &#39;([^)]*)&#39;  # list of hooks calls only</code></pre></td>
</tr>
</tbody>
</table>

## Controller hooks

| Name | Description | Context |
|----|----|----|
| `:controller_account_success_authentication_after` |  | `:user` |
| `:controller_custom_fields_new_after_save` |  | `:params, :custom_field` |
| `:controller_custom_fields_edit_after_save` |  | `:params, :custom_field` |
| `:controller_issues_bulk_edit_before_save` | Passes the current issue and the params to the hook before saving. This can be used to set attributes on the issues. | `:params, :issue` |
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

## Helper hooks

| Name | Description | Context |
|----|----|----|
| `:helper_issues_show_detail_after_setting` | Passes data to the hook to allow it to set the label and value. | `:detail, :label, :value, :old_value` |
| `:helper_queries_column_content` |  | `:content, :column, :item` |
| `:helper_queries_column_value` |  | `:content, :column, :item, :value` |

## Model hooks

| Name | Description | Context |
|----|----|----|
| `:model_changeset_scan_commit_for_issue_ids_pre_issue_update` |  | `:changeset, :issue, :action` |
| `:model_project_copy_before_save` |  | `:source_project, :destination_project` |

## View hooks

The current project is accessible using the `:project` key of the context for all the view hooks.

| Name | Description | Context |
|----|----|----|
| `:view_account_left_bottom` |  | `:user` |
| `:view_account_right_bottom` |  | `:user` |
| `:view_account_login_top` |  | (none) |
| `:view_account_login_bottom` |  | (none) |
| `:view_admin_projects_sidebar_queries_bottom` |  | (none) |
| `:view_calendars_show_bottom` |  | `:year, :month, :project, :query` |
| `:view_custom_fields_form_upper_box` |  | `:custom_field, :form` |
| `:"view_custom_fields_form_#{@custom_field.type.to_s.underscore}"` |  | `:custom_field, :form` |
| `:view_issue_statuses_form` |  | `:issue_status` |
| `:view_groups_memberships_table_header` |  | `:group` |
| `:view_groups_memberships_table_row` |  | `:group, :membership` |
| `:view_issues_bulk_edit_details_bottom` | Appends content to the bulk edit form before the note | `:issues` |
| `:view_issues_edit_top` | Prepends content to the issue edit form | `:issue, :form` |
| `:view_issues_edit_notes_bottom` | Appends content to the note bottom before files form | `:issue, :notes, :form` |
| `:view_issues_form_details_top` | Prepends content to the issue form | `:issue, :form` |
| `:view_issues_form_details_bottom` | Appends content to the html table at the bottom of the issue form | `:issue, :form` |
| `:view_issues_history_journal_bottom` |  | `:journal` |
| `:view_issues_history_changeset_bottom` |  | `:changeset` |
| `:view_issues_history_time_entry_bottom` |  | `:time_entry` |
| `:view_issues_index_bottom` |  | `:issues, :project, :query` |
| `:view_issues_show_details_bottom` | Appends content to the bottom of the issues details table | `:issue` |
| `:view_issues_sidebar_issues_bottom` |  | (none) |
| `:view_issues_sidebar_planning_bottom` |  | (none) |
| `:view_issues_sidebar_queries_bottom` |  | (none) |
| `:view_issues_context_menu_start` |  | `:issues, :can, :back` |
| `:view_issues_context_menu_end` |  | `:issues, :can, :back` |
| `:view_issues_new_top` |  | `:issue` |
| `:view_issues_show_description_bottom` |  | `:issue` |
| `:view_journals_notes_form_after_notes` |  | `:journal` |
| `:view_journals_update_js_bottom` |  | `:journal` |
| `:view_layouts_base_body_bottom` | Appends content to the end of the body section of the base layout | (none) |
| `:view_layouts_base_body_top` | Appends content to the beginning of the body section of the base layout | (none) |
| `:view_layouts_base_content` |  | (none) |
| `:view_layouts_base_html_head` | Appends content to the html head of the base layout | (none) |
| `:view_layouts_base_sidebar` |  | (none) |
| `:view_my_account` |  | `:user, :form` |
| `:view_my_account_contextual` |  | `:user` |
| `:view_my_account_preferences` |  | `:user, :form` |
| `:view_my_page_contextual` |  | `:user` |
| `:view_my_page_splitcontent` |  | `:user` |
| `:view_projects_form` |  | `:project, :form` |
| `:view_projects_copy_only_items` |  | `:project, :f` |
| `:view_projects_roadmap_version_bottom` |  | `:version` |
| `:view_projects_settings_members_table_header` | Appends content to the table header of a Project’s Member setting | `:project` |
| `:view_projects_settings_members_table_row` | Appends content to the table row of a Project’s Member setting | `:member, :project` |
| `:view_projects_show_left` |  | `:project` |
| `:view_projects_show_right` |  | `:project` |
| `:view_projects_show_sidebar_bottom` |  | `:project` |
| `:view_projects_sidebar_queries_bottom` |  | (none) |
| `:view_reports_issue_report_split_content_left` |  | `:project` |
| `:view_reports_issue_report_split_content_right` |  | `:project` |
| `:view_repositories_show_contextual` | Appends content to the contextual menu in the Repositories pane | `:project, :repository` |
| `:view_search_index_options_content_bottom` |  | (none) |
| `:view_timelog_edit_form_bottom` |  | `:time_entry, :form` |
| `:view_time_entries_bulk_edit_details_bottom` |  | `:time_entries` |
| `:view_time_entries_context_menu_start` |  | `:time_entries, :can, :back` |
| `:view_time_entries_context_menu_end` |  | `:time_entries, :can, :back` |
| `:view_settings_general_form` |  | (none) |
| `:view_users_memberships_table_header` |  | `:user` |
| `:view_users_memberships_table_row` |  | `:user, :membership` |
| `:view_users_form` |  | `:user, :form` |
| `:view_users_form_preferences` |  | `:user, :form` |
| `:view_users_sidebar_queries_bottom` |  | (none) |
| `:view_versions_show_bottom` |  | `:version` |
| `:view_versions_show_contextual` |  | `:version, :project` |
| `:view_welcome_index_left` |  | `:project` |
| `:view_welcome_index_right` |  | `:project` |
| `:view_wiki_show_sidebar_bottom` |  | `:wiki, :page` |

## Other hooks

| Name | Description | Context |
|------|-------------|---------|
| `:after_plugins_loaded` | Called after the `init.rb` of all plugins has been loaded | (none) |
