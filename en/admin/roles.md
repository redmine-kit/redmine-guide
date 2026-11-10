---
source: RedmineRoles
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineRoles
source_version: 34
source_updated_on: '2023-01-25T13:56:27Z'
updated_for: 7.0.3
---

# Roles & permissions

A role is a collection of permissions. It lets you define the permissions that the members have on a [project](projects.md).

Each member of a project has one or multiples Role(s) for the project. If a member has multiple roles in a project, the permissions applied to the member is the combination of all roles’ permissions. A user can have different roles for different projects.

You can create new roles or edit existing ones. You can delete a role only if nobody has this role on a project.

![](../../images/RedmineRoles/roles@2x.png)

## Roles properties

- **Name**: display name of the role
- **Issues can be assigned to users with this role**: if unchecked, issues can not be assigned to members with this role on a project.
- **Issues visibility**: controls issue visibility. Assuming that this role includes the View Issues permission, the following rules apply to the issues of the projects the user is tied to through it:
  - *All issues* : the user can see all issues.
  - *All non private issues*: the user can see all issues which are not marked as private and private issues that were created by or assigned to her/him. This is the default.
  - *Issues created by or assigned to the user*: the user can only see issues created by or assigned to her/him.
- **Time logs visibility**: controls time log visibility. Assuming that this role includes the View spent time permission, the following rules apply to the time logs of the projects the user is tied to through it:
  - *All time entries* : the user can see all time logs. This is the default.
  - *Time entries created by the user* : the user can only see time logs created by or assigned to her/him.
- **Users visibility**: controls user visibility (this applies to user profiles, issue filters and user search when adding watchers). The following rules apply to the users of the projects the user is tied to through it and beyond:
  - *All active users* : the user can see all active users (i.e. all active user accounts that are registered in Redmine).
  - *Members of visible projects* : the user can only see users who are members of visible projects. This is the default.

## Permissions

When editing a role, you can define its permissions by checking/unchecking the different actions.

<table>
<thead>
<tr>
<th>Permission</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2"><strong><em>Project permissions</em></strong></td>
</tr>
<tr>
<td>Create project</td>
<td>Allow non-admin users to create a root project<br />You can specify which role will be automatically given to a non-admin user who creates a project (see <a href="settings.md#Projects">RedmineSettings#Projects</a>)</td>
</tr>
<tr>
<td>Edit project</td>
<td>Allow user to edit project properties</td>
</tr>
<tr>
<td>Close / reopen the project</td>
<td>Allow user to close / reopen projects</td>
</tr>
<tr>
<td>Select project modules</td>
<td>Allow user to enable/disable project modules (such as issues tracking, wiki, repository…)</td>
</tr>
<tr>
<td>Manage members</td>
<td>Allow user to add/remove project members or change the roles of existing members</td>
</tr>
<tr>
<td>Manage versions</td>
<td>Allow user to add/edit/delete project versions</td>
</tr>
<tr>
<td>Create subprojects</td>
<td>Allow user to add subprojects to the project</td>
</tr>
<tr>
<td>Manage public queries</td>
<td>Allow user to save/edit/delete public project queries</td>
</tr>
<tr>
<td>Save queries</td>
<td>Allow user to save/edit/delete their private queries</td>
</tr>
<tr>
<td colspan="2"><strong><em>Forums permissions</em></strong></td>
</tr>
<tr>
<td>View messages</td>
<td>Allow user to view the forums and forum activities</td>
</tr>
<tr>
<td>Manage forums</td>
<td>Allow user to add/edit/delete project forums</td>
</tr>
<tr>
<td>Post messages</td>
<td>Allow user to post new topics in forums</td>
</tr>
<tr>
<td>Edit messages</td>
<td>Allow user to edit any message and to remove any message attachments</td>
</tr>
<tr>
<td>Edit own messages</td>
<td>Allow user to edit its own messages only</td>
</tr>
<tr>
<td>Delete messages</td>
<td>Allow user to delete any topic or reply</td>
</tr>
<tr>
<td>Delete own messages</td>
<td>Allow user to delete its own topics or replies</td>
</tr>
<tr>
<td colspan="2"><strong><em>Documents permissions</em></strong></td>
</tr>
<tr>
<td>Add documents</td>
<td>Allow user to add project documents</td>
</tr>
<tr>
<td>Edit documents</td>
<td>Allow user to edit project documents</td>
</tr>
<tr>
<td>Delete documents</td>
<td>Allow user to delete project documents</td>
</tr>
<tr>
<td>View documents</td>
<td>Allow user to view documents</td>
</tr>
<tr>
<td colspan="2"><strong><em>Files permissions</em></strong></td>
</tr>
<tr>
<td>Manage files</td>
<td>Allow user to add/edit/delete project files under the Files section</td>
</tr>
<tr>
<td>View files</td>
<td>Allow user to view files</td>
</tr>
<tr>
<td colspan="2"><strong><em>Issue tracking</em></strong></td>
</tr>
<tr>
<td>Manage issue categories</td>
<td>Allow user to add/edit/delete issue categories</td>
</tr>
<tr>
<td>View Issues</td>
<td>Allow user to view project issues</td>
</tr>
<tr>
<td>Add issues</td>
<td>Allow user to create new issues</td>
</tr>
<tr>
<td>Edit issues</td>
<td>Allow user to fully edit existing issues</td>
</tr>
<tr>
<td>Edit own issues</td>
<td>Allow user to fully edit the issues they created</td>
</tr>
<tr>
<td>Copy issues</td>
<td>Allow user to copy existing issues</td>
</tr>
<tr>
<td>Manage issue relations</td>
<td>Allow user to add/remove relations between issues</td>
</tr>
<tr>
<td>Manage subtasks</td>
<td>Allow user to add/remove subtasks to issues</td>
</tr>
<tr>
<td>Add notes</td>
<td>Allow user to add comments to existing issues</td>
</tr>
<tr>
<td>Edit notes</td>
<td>Allow user to edit any issue comment</td>
</tr>
<tr>
<td>Edit own notes</td>
<td>Allow user to edit its own comments only</td>
</tr>
<tr>
<td>Delete issues</td>
<td>Allow user to delete issues</td>
</tr>
<tr>
<td>View watchers list</td>
<td>Allow user to see who is watching an issue</td>
</tr>
<tr>
<td>Add watchers</td>
<td>Allow user to add other users as watchers of an issue</td>
</tr>
<tr>
<td>Delete watchers</td>
<td>Allow user to remove watchers of an issue</td>
</tr>
<tr>
<td colspan="2"><strong><em>News permissions</em></strong></td>
</tr>
<tr>
<td>View news</td>
<td>Allow user to view the news section and news activities</td>
</tr>
<tr>
<td>Manage news</td>
<td>Allow user to add/edit/delete project news</td>
</tr>
<tr>
<td>Comment news</td>
<td>Allow user to add comments to news</td>
</tr>
<tr>
<td colspan="2"><strong><em>Repository permissions</em></strong></td>
</tr>
<tr>
<td>Manage repository</td>
<td>Allow user to configure the project repository</td>
</tr>
<tr>
<td>Browse repository</td>
<td>Allow user to browse and view the content of the project repository</td>
</tr>
<tr>
<td>View changesets</td>
<td>Allow user to view the changesets</td>
</tr>
<tr>
<td>Commit access</td>
<td>Used by Redmine.pm to give write access to the project repository<br />See <a href="https://www.redmine.org/projects/redmine/wiki/Repositories_access_control_with_apache_mod_dav_svn_and_mod_perl">Repositories_access_control_with_apache_mod_dav_svn_and_mod_perl</a></td>
</tr>
<tr>
<td colspan="2"><strong><em>Time tracking permissions</em></strong></td>
</tr>
<tr>
<td>Log spent time</td>
<td>Allow user to log time on the project</td>
</tr>
<tr>
<td>View spent time</td>
<td>Allow user to view the time logs on the project</td>
</tr>
<tr>
<td>Edit time logs</td>
<td>Allow user to edit any time log</td>
</tr>
<tr>
<td>Edit own time logs</td>
<td>Allow user to edit its own time logs only</td>
</tr>
<tr>
<td>Manage project activities</td>
<td>Allow user add/edit/delete activities</td>
</tr>
<tr>
<td colspan="2"><strong><em>Wiki permissions</em></strong></td>
</tr>
<tr>
<td>Manage wiki</td>
<td>Allow user to create or delete the project wiki<br />Deleting a wiki is an <strong>irreversible</strong> operation, it deletes all pages, their history and all attached files!</td>
</tr>
<tr>
<td>Rename wiki pages</td>
<td>Allow user to rename existing wiki page or assign wiki pages to a parent page</td>
</tr>
<tr>
<td>Delete wiki pages</td>
<td>Allow user to delete wiki pages<br />Deleting a wiki page is an <strong>irreversible</strong> operation, the page and all its history are deleted!</td>
</tr>
<tr>
<td>View wiki</td>
<td>Allow user to view the wiki</td>
</tr>
<tr>
<td>Export wiki pages</td>
<td>Allow user to export wiki pages to various formats (pdf, html, …)</td>
</tr>
<tr>
<td>View wiki history</td>
<td>Allow user to view older versions of the wiki pages, and diff between versions</td>
</tr>
<tr>
<td>Edit wiki pages</td>
<td>Allow user to edit unprotected wiki pages</td>
</tr>
<tr>
<td>Delete attachments</td>
<td>Allow user to delete existing wiki page attachments</td>
</tr>
<tr>
<td>Protect wiki pages</td>
<td>Allow user to lock/unlock wiki pages, and edit locked pages</td>
</tr>
<tr>
<td colspan="2"><strong><em>Calendar permissions</em></strong></td>
</tr>
<tr>
<td>View calendar</td>
<td>Allow user to view the calendar</td>
</tr>
<tr>
<td colspan="2"><strong><em>Gantt permissions</em></strong></td>
</tr>
<tr>
<td>View gantt chart</td>
<td>Allow user to view the gantt chart</td>
</tr>
</tbody>
</table>

## System roles

There are two system roles in Redmine: ‘Non member’ and ‘Anonymous’. They are internally used by Redmine and thus cannot be deleted.

- **Non member**: this role lets you define the permissions that a registered user has on projects which he is not a member of.
- **Anonymous**: this role lets you define the permissions that anonymous users have on the projects.

Note that these two roles only apply to public projects since anonymous users and users who are not a member of a private project cannot even see it.

As a consequence of the fact, that Anonymous and Non member roles cannot be assigned to a specific user or group, but are assigned automatically, the permissions of these roles are global for a given Redmine installation. To be more concrete: You can create different developer-roles (reporter1,reporter2,…) with slightly different permissions to fit specific needs of specific projects. However: you cannot adapt Anonymous and Non member roles in a way, that non-members are allowed to create board-messages in one project, but are forbidden to do so in another project.

Some permissions cannot be given to these roles. For example, the ‘Manage members’ permission cannot be given to non member or anonymous users.
