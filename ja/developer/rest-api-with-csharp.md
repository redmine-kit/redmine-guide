---
source: Rest_api_with_csharp
translated_from_version: 7
---

# .NET で REST API を使う

[Redmine .NET API library](https://github.com/zapadi/redmine-net-api) は、Redmine の API にアクセスできる、無料のサードパーティの C# のライブラリです。オープンソースの Apache 2 ライセンスで公開されています。

PowerShell からこのライブラリを使う方法は、[REST API with PowerShell](https://www.redmine.org/projects/redmine/wiki/REST_API_with_PowerShell) を参照してください。

使い方の例:

```
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
