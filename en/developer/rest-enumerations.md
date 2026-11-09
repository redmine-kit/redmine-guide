---
source: Rest_Enumerations
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Enumerations
source_version: 3
source_updated_on: '2017-03-07T06:10:13Z'
---

# Enumerations

## /enumerations/issue_priorities.:format

### GET

Returns the list of [issue](rest-issues.md) priorities.

<u>Examples</u>:

    GET /enumerations/issue_priorities.xml

<u>Response</u>:

    <code class="xml">
    <?xml version="1.0" encoding="UTF-8"?>
    <issue_priorities type="array">
      <issue_priority>
        <id>3</id>
        <name>Low</name>
        <is_default>false</is_default>
      </issue_priority>
      <issue_priority>
        <id>4</id>
        <name>Normal</name>
        <is_default>true</is_default>
      </issue_priority>
      ...
    </issue_priorities>
    </code>

## /enumerations/time_entry_activities.:format

### GET

Returns the list of [time entry](rest-time-entries.md) activities.

<u>Examples</u>:

    GET /enumerations/time_entry_activities.xml

<u>Response</u>:

    <code class="xml">
    <time_entry_activities type="array">
      <time_entry_activity>
        <id>8</id>
        <name>Design</name>
        <is_default>false</is_default>
      </time_entry_activity>
      ...
    </time_entry_activities>
    </code>

## /enumerations/document_categories.:format

### GET

Returns the list of document categories.

<u>Examples</u>:

    GET /enumerations/document_categories.xml

<u>Response</u>:

    <code class="xml">
    <document_categories type="array">
      <document_category>
        <id>1</id>
        <name>Uncategorized</name>
        <is_default>false</is_default>
      </document_category>
      <document_category>
        <id>2</id>
        <name>User documentation</name>
        <is_default>false</is_default>
      </document_category>
      <document_category>
        <id>3</id>
        <name>Technical documentation</name>
        <is_default>false</is_default>
      </document_category>
    </document_categories>
    </code>
