---
source: RedmineIssueList
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineIssueList
source_version: 27
source_updated_on: '2017-12-24T13:57:08Z'
---

# The issue list

## Overview

The issue list provides a way to look at issues for a project.

![](../../images/RedmineIssueList/issuelist_overview.png)

## Applying and saving filters

The issue list displays open issues by default. By setting the filter you can change the condition of the issues to be listed. Standard and [custom fields](../admin/custom-fields.md) can be used as filters. Once the filters are set, click on **Apply** to refresh the issue list. Click on **Clear** to clear the filters.

![](../../images/RedmineIssueList/applied_issuelist_filters@2x.png)

It is possible to select multiple values at once for a specified field by pressing the **+** button. This will convert the drop-down menu in a selection list. In order to add to the selection list, use the Ctrl key (Windows) / ⌘ key (macOS) on your keyboard.

![](../../images/RedmineIssueList/redmine-multiple-selection@2x.png)

### Custom queries

Filters you built can be saved as custom queries. And you can apply the saved filters with a single click.

Custom queries can be saved by clicking on **Save**.\
A form lets you give it a name and select the columns that you want to be displayed on the issue list for this query (both standard and [custom fields](../admin/custom-fields.md) can be displayed). Checking the **public** attribute will make the query visible to everyone, otherwise only you will see the query.

![](../../images/RedmineIssueList/ext_newquery@2x.png)

Once saved, the query is listed in the [sidebar](issue-list.md#Sidebar).

![](../../images/RedmineIssueList/custom_queries_sidebar@2x.png)

## Shortcut menu

A context menu pops up when right clicking (ALT + Left click for Opera users) on an issue of the issue list.\
This menu offers several shortcuts to quickly edit, reprioritize, reassign, copy, move or delete the issue.

![](../../images/RedmineIssueList/shortcut_menu@2x.png)

Note that you have to **right-click outside of the issue link**, otherwise the browser’s default context menu is displayed.

## Bulk editing issues

From the issue list, you can bulk edit/move/delete issues by selecting multiple issues and then right-click on the selection.\
Issues can be selected either by using the checkboxes or by clicking on the rows with Control or Shift key pressed.\
You can also use the little tick at the upper-left corner of the list to select/unselect all the issues.

![](../../images/RedmineIssueList/bulk-edit@2x.png)

## Sidebar

![](../../images/RedmineIssueList/sidebar.jpg) The contextual sidebar on the right of the issue list provides links to several different things:

- a quicklink to the default issuelist without any other filters applied (thus only open issues), which is useful when you are looking at a custom query and want to get back to the default issue list
- a link to the [issue summary](issue-summary.md), which is a report of all the issues at a project-level (in contrast to the [version overview](version.md) which provides an overview at version-level)
- a link to the [change log](issue-changelog.md), which provides a project-level overview of all closed **and** targeted issues, sorted per target-versions
- links to several levels of custom queries:
  - global (cross-project) queries
    - public queries
    - private queries
  - current-project’s queries
    - public queries
    - private queries
- depending on the [project settings](project-settings.md) it also shows a planning section with links to:
  - the [calendar](calendar.md)
  - the [gantt](gantt.md) chart
