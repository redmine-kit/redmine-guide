---
source: Rest_Trackers
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Trackers
source_version: 3
source_updated_on: '2021-07-06T12:31:38Z'
---

# Rest Trackers

## /trackers.:format

### GET

Returns the list of all trackers.

<u>Examples</u>:

    GET /trackers.xml

<u>Response</u>:

    <code class="xml">
    <?xml version="1.0" encoding="UTF-8"?>
    <trackers type="array">
      <tracker>
        <id>1</id>
        <name>Defect</name>
        <default_status id="1" name="New"/>
        <description>Description for Bug tracker</description>
        <enabled_standard_fields type="array">
          <field>assigned_to_id</field>
          <field>category_id</field>
          <field>fixed_version_id</field>
          <field>parent_issue_id</field>
          <field>start_date</field>
          <field>due_date</field>
          <field>estimated_hours</field>
          <field>done_ratio</field>
          <field>description</field>
        </enabled_standard_fields>
      </tracker>
      <tracker>
        <id>2</id>
        <name>Feature</name>
        <default_status id="1" name="New"/>
        <description>Description for Feature request tracker</description>
        <enabled_standard_fields type="array">
          <field>assigned_to_id</field>
          <field>category_id</field>
          <field>fixed_version_id</field>
          <field>parent_issue_id</field>
          <field>start_date</field>
          <field>due_date</field>
          <field>estimated_hours</field>
          <field>done_ratio</field>
          <field>description</field>
        </enabled_standard_fields>
      </tracker>
    </trackers>
    </code>

- `description`: available since Redmine 4.2.0
- `enabled_standard_fields`: available since Redmine 5.0.0
