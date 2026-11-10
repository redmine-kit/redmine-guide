---
source: Rest_api_with_java
translated_from_version: 19
---

# Java で REST API を使う

## taskadapter の Redmine Java API library

[Redmine Java API library](https://github.com/taskadapter/redmine-java-api) は、Redmine の API にアクセスできる、無料のサードパーティの Java のライブラリです。オープンソースの Apache 2 ライセンスで公開されています。\
使い方の例:

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
