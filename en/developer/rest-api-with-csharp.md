---
source: Rest_api_with_csharp
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_csharp
source_version: 7
source_updated_on: '2026-04-20T16:44:23Z'
---

# Using the REST API with .NET

[Redmine .NET API library](https://github.com/zapadi/redmine-net-api) is a FREE third-party C# library that can be used to access the Redmine API. It is released under Apache 2 open-source license.

To use this library from PowerShell, see [REST API with PowerShell](https://www.redmine.org/projects/redmine/wiki/REST_API_with_PowerShell)

Sample usage:

```text
using System;
using System.Collections.Specialized;
using Redmine.Net.Api;
using Redmine.Net.Api.Types;

namespace RedmineTest
{
    class Program
    {
        static void Main(string[] args)
        {
            string host = "";
            string apiKey = "";
            string issueId = "<issue-id>";

            var manager = new RedmineManager(host, apiKey);

            //parameter - fetch associated relations.
            var parameters = new NameValueCollection {{RedmineKeys.INCLUDE, RedmineKeys.RELATIONS}};

            var issue = manager.GetObject<Issue>(issueId, parameters);
            Console.WriteLine("Issue: {0}.", issue);

            //Create a issue.
            Issue newissue = new Issue();
            newissue.Project = IdentifiableName.Create<IdentifiableName>(id: 1);
            newissue.Tracker = IdentifiableName.Create<IdentifiableName>(id: 1);
            newissue.Subject = "Example";
            newissue.Description = "Description";

            Issue savedIssue = manager.CreateObject(newissue);
            Console.WriteLine("Saved issue {0}." ,savedIssue);

        }
    }
}
```
