---
source: Rest_api_with_java
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_java
source_version: 19
source_updated_on: '2021-04-05T17:16:24Z'
---

# Using the REST API with Java

## Redmine Java API library from taskadapter

[Redmine Java API library](https://github.com/taskadapter/redmine-java-api) is a FREE third-party Java library that can be used to access the Redmine API. It is released under Apache 2 open-source license.\
Sample usage:

```java
String uri = "https://www.hostedredmine.com";
String apiAccessKey = "a3221bfcef5750219bd0a2df69519416dba17fc9";
String projectKey = "taskconnector-test";
Integer queryId = null; // any

RedmineManager mgr = RedmineManagerFactory.createWithApiKey(uri, apiAccessKey);
IssueManager issueManager = mgr.getIssueManager();
List<Issue> issues = issueManager.getIssues(projectKey, queryId);
for (Issue issue : issues) {
    System.out.println(issue.toString());
}

// Create issue
Issue issueToCreate = IssueFactory.createWithSubject("some subject");
Issue createdIssue = issueManager.createIssue(projectKey , issueToCreate);

// Get issue by ID:
Issue issue = issueManager.getIssueById(123);
```
