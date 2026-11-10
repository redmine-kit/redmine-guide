---
source: Rest_api_with_ruby
translated_from_version: 15
---

# Ruby で REST API を使う

Redmine の REST API は Rails の RESTful の規約に従っているので、[ActiveResource](http://api.rubyonrails.org/classes/ActiveResource/Base.html) で簡単に使えます。

## ActiveResource (Rails)

Redmine 3.x(Rails 4.2)では、「activeresource」の gem を追加する必要があります。\
たとえば Gemfile.local に次のように書きます。

```ruby
gem 'activeresource'
```

Redmine の REST API の使い方を示す、簡単な Ruby のスクリプトです。

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

*ActiveResource のクラスで `include_root_in_json = true` を設定する必要がある場合があります*

## Ruby だけで使う(Ruby の標準機能のみ)

`net/http` の PUT リクエストで、チケット #9599 のステータスを、内部の status_id 1 にする例です。

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
