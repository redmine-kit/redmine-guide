---
source: Getting_Started
source_url: https://www.redmine.org/projects/redmine/wiki/Getting_Started
source_version: 9
source_updated_on: '2018-11-14T10:48:11Z'
updated_for: 7.0.3
---

# Getting Started

This is a guide to the basics of Redmine, written from a new user’s perspective. We’ll avoid the fancy stuff for now and just go over ***creating a project***, ***working with issues*** and ***the basic workflow***.

## Step One — Creating a project

Before you let loose your development team, you’ll want to set up a project for them to work on. This can be done as the Admin user (username and password are both “admin”). Click on ***Projects*** (upper left), then on ***New project*** (upper right). Fill in all the data. A description of some of the fields can be found [here](project-settings.md). The only box that might be confusing is the Project Identifier — this is used internally by Redmine (for URLs and other things).

## Step Two — Get some Users

You’ll want to get a few users registered, so that you can assign them to the project. Note that by default, you must activate users manually. So after a user fills out the registration page, you must log in as Admin, navigate to Administration:Users, and change the **Status** filter (which shows only active users by default) to list the registered users. Activate users as necessary.

Once active, you can assign a user to a project. When you do this you can specify one or more ***roles*** that they play. The default options for roles are:

- Manager
- Developer
- Reporter

These roles affect what each user is allowed to do within each project. It should be noted that assigning a role affects permissions in two different areas:

1.  First, a role will affect permissions across all aspects of a project. For example, the Manager role will allow a user to create new (sub)projects, to manage the Forums, the Wiki, the Repository and anything else (in general) within a project. By contrast, the Developer role will not be able to edit the Project or delete messages from the Forums.
2.  Second, a role will affect permissions on the Workflow. In general, a new Issue progresses through various states from **New** to **In Progress** to **Resolved** to **Closed**. One of the key differences between Managers and Developers is that Managers are allowed to Reject issues, but Developers are not. (More on this below in the explanation of Workflow).

## Workflows…You Can’t Explain That!

***Workflows*** are how Redmine tracks issues from creation through completion. The default Workflow contains the following states:

- New
- In Progress
- Resolved
- Feedback
- Closed
- Rejected

By default, anyone who’s logged in can create an issue (Bug, Feature or Support), but only Managers can Reject them or Reopen a closed issue.

### Resolved vs Closed?

There’s a lot of discussion on the Internet about this, but the general consensus is that Resolved means a Developer thinks he’s fixed the bug, and Closed means the original reporter or a Manager has signed off on it. Many blogs talk about this — such as http://journal.sifterapp.com/blog/2011/07/resolved-vs-closed/.

## Step Three — Create Issues

TBD

## Step Four — Work on Issues

TBD

## Step Five — Close Issues

TBD
