---
source: RedmineCustomFields
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineCustomFields
source_version: 29
source_updated_on: '2021-09-30T14:54:07Z'
updated_for: 7.0.3
---

# Custom fields

Custom fields allow you to add additional information to several types of data used in Redmine. See ‘[custom field types](custom-fields.md#Custom-field-types)’ for all types of data which come with support for custom fields.\
Each custom field can be defined to be of a [certain type](custom-fields.md#Custom-field-supporting-data-types).

## Custom field types

### Format

A custom field can be of one the following type:

- **Boolean**: checkbox
- **Date**: date
- **File**: file attached to the object
- **Float**: floating point number
- **Integer**: positive or negative number
- **Key/value list**: drop down list whose values can be renamed (see [Lists and Key/Values list](custom-fields.md#Lists-and-KeyValues-list))
- **Link**: URL
- **List**: drop down list
- **Long Text**: resizeable multiple lines of text (supports rich text formatting as of 2.50)
- **Progress bar**: percentage between 0 and 100, displayed as a progress bar (since 6.1.0)
- **Text**: single line of text (supports rich text formatting as of 2.50)
- **User** custom field format that can be used to reference a project member
- **Version** custom field format that can be used to reference version

### Validation

Some validations can be defined for each custom field:

- **Min - max length**: minimum and maximum length for the field (0 means that there is no restriction)
- **Regular Expression**: a regular expression can be used to validate the field content. Examples:
  1.  *4 capital letters followed by one or several digits*

      ```text
      ^\[A-Z]{4}\d+$
      ```

  2.  *characters only, no digits*

      ```text
      ^[^0-9]*$
      ```

- A full list of regular expressions can be found in the Ruby Users Guide.

### Values

Some field support multiple values and default values.

- **Multiple values**: while enabled, more than one item may be selected.
- **Possible values**: possible values for the “List” fields. One line for each value.
- **Default value**: default value to apply if none selected.

### Text formatting

Some fields support text formatting.

- **Text formatting**: whether to wikify the text. If enabled, then *locks* the **Link values to URL** field.

### Lists and Key/Values list

You can create your own list of values which you want your users to add. A posteriori change in values of “List” type will not affect any existing records created in the past, while a change in values of “Key/value list” will also affect existing records created in the past.

### Link values to URL

“Link values to URL” can be defined for boolean, date, float, integer, key/value list, list and text format fields.

- **Link values to URL**: creates a URL using the following variables.
  - `%value%` =\> the custom field value
  - `%id%` =\> id of the customized object
  - `%project_id%` =\> id of the project of the customized object if defined
  - `%project_identifier%` =\> identifier of the project of the customized object if defined
  - `%m1%, %m2%...` =\> capture groups matches of the custom field regexp if defined

Example:

```text
https://www.redmine.org/issues/%value%
```

### Input field styling

(2.5.2+) Some fields may be displayed as radio buttons or checkboxes, with slightly different behaviour based on the selected “Format”:

- **Boolean**: checkbox (enabled/disabled) or radio buttons (null/yes/no)
- **List**, **User** and **Version**:
  - checkboxes (if **Multiple values** is enabled)
  - radio buttons (if **Multiple values** is disabled)

## Custom field supporting data types

### Fields for Issues

Data in issue custom fields can be used and/or will be displayed in [issues](../user/issues.md), [issue lists](../user/issue-list.md), [custom queries](../user/issue-list.md#Custom-queries) and the [Timelog report](../user/timelog-report.md).

- **Trackers**: TODO
- **Required**: field which is required in order to create/save an issue
- **For all projects**: if checked, this field is used for the issues of all the projects. If unchecked, each project can choose whether or not to use the field for its issues (see [Project settings](../user/project-settings.md)).
- **Used as a filter**: TODO
- **Searchable**: field which is searchable using the Redmine [search function](../user/search.md)

### Fields for Spent time entries

Data in spent time entry custom fields can be used and/or will be displayed in the [Timelog report](../user/timelog-report.md).

- **Required**: field which is required in order to create/save a spent time entry

### Fields for Projects

Data in project custom fields can be used and/or will be displayed in the [Project overview](../user/project-overview.md).

- **Required**: field which is required in order to create/save a project
- **Searchable**: field which is searchable using the Redmine [search function](../user/search.md)

### Fields for Versions

Data in version custom fields can be used and/or will be displayed in the [Roadmap](../user/roadmap.md) and the [Version overview](../user/version.md).

- **Required**: field which is required in order to create/save a version

### Fields for Users

Data in user custom fields can be used and/or will be displayed in the [user profiles](https://www.redmine.org/projects/redmine/wiki/RedmineUserProfiles).

- **Required**: field which is required in order to create/save a user
- **Visible**: field which is displayed in the [user profile](https://www.redmine.org/projects/redmine/wiki/RedmineUserProfiles)
- **Editable**: field which is editable by the [Redmine user](../user/accounts.md) owning the user account

### Fields for Groups

Data in group custom fields can be edited in the group form and is displayed on the group page.

### Fields for Activities (time tracking)

Data in time tracking activity custom fields can be used and/or will be displayed<sup>1</sup> in the [Timelog report](../user/timelog-report.md) and the [Project settings](../user/project-settings.md#Activities-time-tracking). See also [#4077](https://www.redmine.org/issues/4077) for some details about this nifty feature.

- **Required**: field which is required in order to create/save an activity

### Fields for Issue priorities

**Note**: issue priority custom fields are not (yet) used in the Redmine core, though other plugins or themes *can/may* use them. No setting here has any effect on any other parts of Redmine for the time being.

### Fields for Document categories

**Note**: document category custom fields are not (yet) used in the Redmine core, though other plugins or themes *can/may* use them. No setting here has any effect on any other parts of Redmine for the time being.

<sup>1</sup> there are some exceptions, see [#19121](https://www.redmine.org/issues/19121)#note-1.
