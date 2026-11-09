---
source: Rest_Groups
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_Groups
source_version: 10
source_updated_on: '2021-09-09T13:29:39Z'
---

# Groups

## /groups.:format

### GET

Returns the list of groups.

This endpoint requires admin privileges.

<u>Example</u>:

GET /groups.xml

<u>Response</u>:

    <groups type="array">
      <group>
        <id>53</id>
        <name>Managers</name>
      </group>
      <group>
        <id>55</id>
        <name>Developers</name>
      </group>
    </groups>

### POST

Creates a group.

This endpoint requires admin privileges.

<u>Parameters</u>:

- `group` (required): a hash of the group attributes, including:

\* `name` (required): the group name\
\* `user_ids`: ids of the group users (an empty group is created if not provided)

<u>Example</u>:

    POST /groups.xml

    <group>
      <name>Developers</name>
      <user_ids type="array">
        <user_id>3</user_id>
        <user_id>5</user_id>
      </user_ids>
    </group>

    POST /groups.json

    {
      "group": {
        "name": "Developers",
        "user_ids": [ 3, 5 ]
      }
    }

<u>Response</u>:

\* `201 Created`: group was created\
\* `422 Unprocessable Entity`: group was not created due to validation failures (response body contains the error messages)

## /groups/:id.:format

### GET

Returns details of a group.

This endpoint requires admin privileges.

<u>Parameters</u>:

- `include` (optional): a coma separated list of associations to include in the response:

\* `users`\
\* `memberships`

<u>Example</u>:

GET /groups/20.xml?include=users

<u>Response</u>:

    <group>
      <id>20</id>
      <name>Developers</name>
      <users type="array">
        <user id="5" name="John Smith"/>
        <user id="8" name="Dave Loper"/>
      </users>
    </group>

### PUT

Updates an existing group.

This endpoint requires admin privileges.

### DELETE

Deletes an existing group.

This endpoint requires admin privileges.

## /groups/:id/users.:format

### POST

Adds an existing user to a group.

This endpoint requires admin privileges.

<u>Parameters</u>:

- `user_id` (required): id of the user to add to the group.

<u>Example</u>:

    POST /groups/10/users.xml

    <user_id>5</user_id>

<u>Response</u>:

- `204 No Content`: user was added to the group

## /groups/:id/users/:user_id.:format

### DELETE

Removes a user from a group.

This endpoint requires admin privileges.

<u>Example</u>:

    DELETE /groups/10/users/5.xml

<u>Response</u>:

- `204 No Content`: user was removed to the group
