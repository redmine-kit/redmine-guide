---
source: Plugin_Internals
source_url: https://www.redmine.org/projects/redmine/wiki/Plugin_Internals
source_version: 24
source_updated_on: '2022-09-16T07:36:06Z'
---

# Plugin Internals

This page will be used as a central place to store information about plugin-development in Redmine.

## Overriding the Redmine Core

You can override views but not controllers or models in Redmine. Here’s how Redmine/Rails works if you try to override a controller (or model) and a view for a fictional plugin `MyPlugin`:

### Controllers (or models)

1.  Rails bootstraps and loads all its framework
2.  Rails starts to load code in the plugins
3.  Rails finds `IssueController` in MyPlugin and see it defines a `show` action
4.  Rails loads all the other plugins
5.  Rails then loads the application from *../app*
6.  Rails finds `IssueController` again and see it also defines a `show` action
7.  Rails (or rather Ruby) overwrites the `show` action from the plugin with the one from *../app*
8.  Rails finishes loading and serves up requests

### Views

View loading is very similar but with one small difference (because of Redmine’s patch to Engines)

1.  Rails bootstraps and loads all its framework
2.  Rails starts to load code in the plugins
3.  Rails finds a views directory in *../vendor/plugins/my_plugin/app/views* and **pre-pends** it to the views path
4.  Rails loads all the other plugins
5.  Rails then loads the application from *../app*
6.  Rails finishes loading and serves up requests
7.  Request comes in, and a view needs to be rendered
8.  Rails looks for a matching template and loads the plugin’s template since it was **pre-pended** to the views path
9.  Rails renders the plugins’view

Due to the fact that it is so easy to extend models and controllers the Ruby way (via including modules), Redmine shouldn’t (and doesn’t) maintain an API for overriding the core’s models and/or controllers. Views on the other hand are tricky (because of Rails magic) so an API for overriding them is way more useful (and thus implemented in Redmine).

To override an existing Redmine Core view just create a view file named exactly after the one in *../app/views/* and Redmine will use it. For example to override the project index page add a file to *../vendor/plugins/my_plugin/app/views/projects/index.html.erb*.

## Extending the Redmine Core

As explained above: you rarely want to override a model/controller. Instead you should either:

- add new methods to a model/controller or
- wrap an existing method.

### Adding a new method

A quick example of **adding a new method** can be found on Eric Davis’ [Budget plugin](http://github.com/edavis10/redmine-budget-plugin/blob/5076b1c88b57c2068aa92cdf694769dbd22d061a/lib/issue_patch.rb). Here he added a new method to Issue called `deliverable_subject` and also declared a relationship.

    <code class="ruby">
    module IssuePatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        # Wraps the association to get the Deliverable subject.  Needed for the 
        # Query and filtering
        def deliverable_subject
          unless self.deliverable.nil?
            return self.deliverable.subject
          end
        end
      end
    end
    </code>

### Wrapping an existing method

\> **Caution!**\
\> The alias_method_chain pattern is deprecated in Rails 5 so this technique is only applicable to Redmine versions below 4.0.0.

A quick example of **wrapping an existing method** can be found on Eric Davis’ [Rate plugin](http://github.com/edavis10/redmine_rate/blob/4666ddb10e1061ca3ef362735d0d264676b99024/lib/rate_users_helper_patch.rb). Here he uses the `alias_method_chain` to hook into the UsersHelper and wrap the `user_settings_tabs` method. So when the Redmine Core calls `user_settings_tabs` the codepath looks like:

1.  Redmine Core calls `UsersHelper#user_settings_tabs`
2.  `UsersHelper#user_settings_tabs` runs (which is actually `UsersHelper#user_settings_tabs_with_rate_tab`)
3.  `UsersHelper#user_settings_tabs_with_rate_tab` calls the original `UsersHelper#user_settings_tabs` (renamed to `UsersHelper#user_settings_tabs_without_rate_tab`)
4.  The result then has a new Hash added to it
5.  `UsersHelper#user_settings_tabs_with_rate_tab` returns the combined result to the Redmine core, which is then rendered

<!-- -->

    <code class="ruby">
    module RateUsersHelperPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          alias_method_chain :user_settings_tabs, :rate_tab
        end
      end

      module InstanceMethods
        # Adds a rates tab to the user administration page
        def user_settings_tabs_with_rate_tab
          tabs = user_settings_tabs_without_rate_tab
          tabs << { :name => 'rates', :partial => 'users/rates', :label => :rate_label_rate_history}
          return tabs
        end
      end
    end
    </code>

It is important to note that this kind of wrapping can only be done once per method. In the case of multiple plugins using this trick, then only the last evaluation of the `alias_method_chain` would be valid and all the previous ones would be ignored.

[`alias_method_chain`](http://apidock.com/rails/v3.2.13/Module/alias_method_chain) is a pretty advanced method but it’s also really powerful.

## Using Rails callbacks in Redmine plugins

When you want to hook into all issues which are saved/created for example, you can better use [Rails callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html) instead of Redmine [hooks](hooks.md). Main reason for this is that the `:controller_issues_edit_before_save`-hook is not triggered when a new issue is created.\
For example see the implementation of this in Eric Davis’ “Kanban plugin”:

1.  http://github.com/edavis10/redmine_kanban/blob/000cf175795c18033caa43082c4e4d0a9f989623/init.rb#L10
2.  http://github.com/edavis10/redmine_kanban/blob/000cf175795c18033caa43082c4e4d0a9f989623/lib/redmine_kanban/issue_patch.rb#L13

This will make sure that `issue.update_kanban_from_issue` runs every time an issue is saved (new or updated).

If you want to hook into new issues only you can use the `before_create` callback instead of the `after_save` callback. If you want to make sure that the issue indeed is saved successfully before your code is executed you could better use the `after_create`-callback.

## Hooking in MyPage

### FAQ

- Why is the drop-down selection for my blocks not localized? The Name of the entry in the drop-dwon box is per convention made of the entry in the locale file of the plugin. This entry must have the same name as the “my site” block filename, e.g. redmine/vendor/plugins/<myplugin_folder>/app/views/my/blocks/<myblocks_view_file_name>.erb. So you need to add a line “<myblocks_view_file_name>: <put here translation for the drop down item in my blocks configuration>” in your locale, e.g redmine/vendor/plugins/<myplugin_folder>/config/locale/en.yml.

If this string is not defined in locale file, alyways the filename <myblocks_view_file_name> without extension is made for label in drop-down.

## References

- message#4283
- message#4095
