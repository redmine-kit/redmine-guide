---
source: RedmineGroups
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineGroups
source_version: 6
source_updated_on: '2012-12-08T10:16:32Z'
updated_for: 7.0.3
---

# Managing Groups

As of 0.9, Administrators can define groups of users in Redmine.\
Groups can be added as members of projects just like regular users, using the same [Roles](roles.md) too.

When adding a user to an existing group, this user inherits of all of the group privileges.

## Creating groups

To create a group, do the following:

1.  Click Administration
2.  Click Groups
3.  Click New Group
4.  Type the name of your group in Name
5.  Click Create

## Adding members and associating projects

To add members to a group, do the following:

1.  In Administration \>\> Groups
2.  Click the name of the Group you wish to change.
3.  You’ll see 3 tabs: General, Users, Projects
    - General
      - Change the name by editing the Name field
    - Users
      - Click New user and check the box for each user to add
      - Click Add
    - Projects
      - Click Add projects and check the projects
      - Check the roles
      - Click Add

![](../../images/en/RedmineGroups/RedmineMemberToGroupNew@2x.png)\
Figure 1: Example Group Users tab

![](../../images/en/RedmineGroups/RedmineMembersToGroup@2x.png)\
Figure 2: Adding Members to a Group

![](../../images/en/RedmineGroups/RedmineGroupToProjectNew@2x.png)\
Figure 3: Example Group Project tab

![](../../images/en/RedmineGroups/RedmineGroupToProjects@2x.png)\
Figure 4: Associating a group to a project (from the Group context)
