---
source: Rest_api_ẅith_python
translated_from_version: 18
---

# Python で REST API を使う

Python で REST API を使えるライブラリの一覧です。

1.  [Python-Redmine](https://python-redmine.com)
2.  [PyRedmineWS](https://github.com/ianepperson/pyredminews)
3.  [PyActiveResource](http://code.google.com/p/pyactiveresource/)
4.  [PyRed](https://github.com/alourie/pyred)

## **Python-Redmine**:

Python-Redmine は、Redmine の REST API のすべての機能に対応したライブラリです。よく知られた Django の ORM にならった、シンプルで強力な Python らしい API を備え、十分にテストされています。例:

```python
>>> from redminelib import Redmine

>>> redmine = Redmine('http://demo.redmine.org', username='foo', password='bar')
>>> project = redmine.project.get('vacation')

>>> project.id
30404

>>> project.identifier
'vacation'

>>> project.created_on
datetime.datetime(2013, 12, 31, 13, 27, 47)

>>> project.issues
<redminelib.resultsets.ResourceSet object with Issue resources>

>>> project.issues[0]
<redminelib.resources.Issue [#34441](https://www.redmine.org/issues/34441) "Vacation">

>>> dir(project.issues[0])
['assigned_to', 'author', 'created_on', 'description', 'done_ratio',
'due_date', 'estimated_hours', 'id', 'priority', 'project', 'relations',
'start_date', 'status', 'subject', 'time_entries', 'tracker', 'updated_on']

>>> project.issues[0].subject
'Vacation'

>>> project.issues[0].time_entries
<redminelib.resultsets.ResourceSet object with TimeEntry resources>
```

## **PyRedmineWS** の例:

Eric が病気で数日休んだとします。Parrot というプロジェクトを調べ、Eric が担当するチケットの期日をすべて 2 週間後ろにずらす必要があります。

dateutil ライブラリには、相対的な日付を計算する relativedelta という便利なメソッドがあります。

```python
# Import the Redmine class
from redmine import Redmine
from dateutil.relativedelta import relativedelta

server = Redmine('http://my-server.com', username='Me', password='seakrit')
project = server.projects['parrot']

# Find Eric in the user data
for u in server.users:
    if u.firstname == 'Eric' and u.lastname == 'Idle':
       user = u
       break
else:
    raise Exception("Didn't find Eric Idle in the user dateabase")

# Extend issues in project assigned to user by two weeks
for issue in project.issues(assigned_to_id=user.id):
    if issue.due_date is not None:
       issue.due_date += relativedelta(weeks=+2)
       issue.save('Giving Eric more time to complete - he was out ill')

```

## **PyActiveResource** の例:

```python
# Importing pyactiveresource
from pyactiveresource.activeresource import ActiveResource

class Issue(ActiveResource):
    _site = 'http://redmine.foo.org'
    _user = 'username'
    _password = 'password'

# Get issues
issues = Issue.find()

# Get a specific issue, from its id
issue = Issue.find(1345)

# Issue attributes

# Updating an attribute

```

## **PyRed** の例: 未定
