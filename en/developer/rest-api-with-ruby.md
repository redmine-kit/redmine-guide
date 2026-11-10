---
source: Rest_api_with_ruby
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_ruby
source_version: 15
source_updated_on: '2017-06-19T01:12:36Z'
---

# Using the REST API with Ruby

Redmine REST API follows the Rails’s RESTful conventions, so using it with [ActiveResource](http://api.rubyonrails.org/classes/ActiveResource/Base.html) is pretty straightforward.

## ActiveResource (Rails)

On Redmine 3.x (Rails 4.2), you need to add ‘activeresource’ gem.\
For example, at Gemfile.local:

```ruby
gem 'activeresource'
```

Here is a simple ruby script that demonstrates how to use the Redmine REST API:

```ruby
require 'rubygems'
require 'active_resource'

# Issue model on the client side
class Issue < ActiveResource::Base
  self.site = 'http://redmine.server/'
  self.user = 'foo'
  self.password = 'bar'
  # Or you can use the Redmine-API key
  # self.headers['X-Redmine-API-Key'] = 'baz'
end

if false
  # Retrieving issues
  issues = Issue.find(:all)
  puts issues.first.subject
end

# Retrieving an issue
issue = Issue.find(1)
puts issue.description
puts issue.author.name

# Creating an issue
issue = Issue.new(
  :subject => 'REST API',
  :assigned_to_id => 1,
  :project_id => 1
# custom field with id=2 exist in database
  :custom_fields => [{id: 2, value: "IT"}]
)
if issue.save
  puts issue.id
else
  puts issue.errors.full_messages
end


# Updating an issue
issue = Issue.find(1)
issue.subject = 'REST API'
issue.save

# Deleting an issue
issue = Issue.find(1)
#issue.destroy
```

*You may need to set `include_root_in_json = true` in your ActiveResource class*

## Pure Ruby (Using only Ruby Core)

Here is an example to set the status of Issue #9599 to internal status_id 1 with a `net/http` PUT-request:

```ruby
require 'net/https'
require 'uri'
require 'json'

def update_issue_status issue_id, new_status_id, change_note
  base_url = "https://your.redmine.example.com"
  api_token = "xxxxxxxxxxxxxxx"

  payload = {
    issue: {
      notes: change_note,
      status_id: new_status_id
    }
  }

  url = "#{base_url}/issues/#{issue_id}.json"
  uri = URI.parse(url)
  req = Net::HTTP::Put.new(uri.request_uri)

  req["Content-Type"] = "application/json"
  req['X-Redmine-API-Key'] = api_token
  req.body = payload.to_json

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(req)
  return response
end

# Set Status of issue #9599 to internal status_id = 1
response = update_issue_status 9599, 1, "Changed Issue Status via REST-API"
```
