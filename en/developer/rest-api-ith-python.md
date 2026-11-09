---
source: Rest_api_ẅith_python
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_ẅith_python
source_version: 18
source_updated_on: '2017-04-10T21:33:00Z'
---

# Using the REST API with Python

Here is the list of available libraries for using REST API with Python:

1.  [Python-Redmine](https://python-redmine.com)
2.  [PyRedmineWS](https://github.com/ianepperson/pyredminews)
3.  [PyActiveResource](http://code.google.com/p/pyactiveresource/)
4.  [PyRed](https://github.com/alourie/pyred)

## **Python-Redmine**:

Python-Redmine is a library which supports 100% features of Redmine’s REST API. It provides a simple but powerful Pythonic API inspired by a well-known Django ORM and is thoroughly tested. Example:

    <code class="python">
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
    <redminelib.resultsets.ResourceSet object with TimeEntry resources></code>

## **PyRedmineWS** example:

Suppose Eric fell ill and was out for several days. You need to crawl through the project called Parrot and move any due date for issues assigned to Eric out by two more weeks.

The dateutil library contains a handy method called relativedelta for calculating relative dates.

    <code class="python">
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

    </code>

## **PyActiveResource** example:

    <code class="python">
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

    </code>

## **PyRed** example: TBD
