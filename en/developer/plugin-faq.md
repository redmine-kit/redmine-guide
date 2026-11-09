---
source: Plugin_FAQ
source_url: https://www.redmine.org/projects/redmine/wiki/Plugin_FAQ
source_version: 8
source_updated_on: '2021-08-22T10:21:22Z'
---

# Frequently Asked Questions about Redmine plugins

This page aims at documenting how to achieve simple things in Redmine plugins.

## Determine if a module is enabled

If your project is in the @`project` variable:

    <code class="ruby">
    if @project.module_enabled?("<module_name>")
    </code>

First *modules* are a project level concept. So be sure to make this check in an action that operates at project level. Redmine core generally uses a `before_filter` called `find_project` to find the current project in standard actions, which populates the @`project` variable.

Available modules as of Redmine 2.3.x are: boards, calendar, documents, files, gantt, issue_tracking, news, repository, time_tracking, wiki. Each plugin can add its own module (see [Plugin_Tutorial](plugin-tutorial.md) which adds a “polls” module).

## Changing the layout of a page

Changing the layout of a page is done by overriding its View. Redmine stores its views in `app/views/`. To change a page’s view using a plugin, first copy the view from `app/views/` to `plugins/your_plugin/app/views/` and then modify the file.

If multiple plugins override the same view, the last plugin loaded will be the one whose view is shown. If you are having trouble finding out which view you need to override, check `config/routes.rb` and look for a pattern that matches the URL for the page you are trying to modify. That may help point you in the right direction.

## Retrieve Redmine application configuration values

Redmine stores application configuration values in a file named `config/configuration.yml`. To retrieve (get) these configuration values from a plugin, Redmine provides the getter method `[]`, which is defined as a class method on `Redmine::Configuration`.

Example[^1]:

Consider the following example configuration:

    <code class="yaml">
    email_delivery:
        delivery_method: :smtp
        smtp_settings:
          address: "myaddress.com" 
          port: 25
          domain: "mydomain.com"
    </code>

Then the value of the `address` configuration key can be retrieved by calling:

    <code class="ruby">Redmine::Configuration['email_delivery']['smtp_settings'][:address]</code>

## Retrieve Redmine settings values

Redmine stores application settings values in the database. This includes any plugin settings. To interact (get/set) with these settings values from a plugin, Redmine automatically provides getter and setter methods in the form of `Setting.some_setting_name` and `Setting.some_setting_name = "some value"`, for each setting on the `Setting` model.

Examples:

- retrieve the value of the internal (Redmine core) ‘welcome text’ setting by calling:
      <code class="ruby">
      Setting.welcome_text
      </code>
- retrieve the value of the ‘notification_default’ setting, as “provided” by the Polls plugin as documented in the [Plugin Tutorial](plugin-tutorial.md), by calling:
      <code class="ruby">
      Setting.plugin_polls['notification_default']
      </code>

It is not recommended to manually modify (set) settings values from a plugin. Instead, set these values via the provided UI’s.

## Require a certain Redmine version

Sometimes plugins require a specific feature implemented in the Redmine core or the plugin overrides a specific view which requires you to control on which (specific) versions of Redmine the plugin can be installed to assure that the required core is available. Such prevents a lot of issues regarding plugin-compatibility.

The above can be accomplished by utilizing the `requires_redmine` method (see source:/trunk/lib/redmine/plugin.rb@19983#L227). Utilisation of the method provides an easy, reliable way to create plugins that require a specific version of Redmine and which are setup to stop Redmine with a message about a non-supported version if the version-requirement is not met.

Note: do not pass a Redmine version number with a *branch suffix* (`stable`/@devel`) to `requires_redmine@; that’s not supported. See \[#35345](https://www.redmine.org/issues/35345) for a discussion about this.

{{collapse(View usage examples for requires_redmine method…)

    <code class="ruby">
    # Requires Redmine 0.7.3 or higher
    requires_redmine :version_or_higher => '0.7.3'
    requires_redmine '0.7.3'

    # Requires Redmine 0.7.x or higher
    requires_redmine '0.7'

    # Requires a specific Redmine version
    requires_redmine :version => '0.7.3'              # 0.7.3 only
    requires_redmine :version => '0.7'                # 0.7.x
    requires_redmine :version => ['0.7.3', '0.8.0']   # 0.7.3 or 0.8.0

    # Requires a Redmine version within a range
    requires_redmine :version => '0.7.3'..'0.9.1'     # >= 0.7.3 and <= 0.9.1
    requires_redmine :version => '0.7'..'0.9'         # >= 0.7.x and <= 0.9.x
    </code>

\
}}

## Require a certain Redmine plugin version

Sometimes plugins require a specific feature implemented in another Redmine plugin or even a feature that is implemented in a specific version of another plugin which requires you to control dependencies on which the plugin relies before it can be installed to assure that the required plugin (version) is available. Such prevents a lot of issues regarding (inter) plugin-compatibility.

The above can be accomplished by utilizing the `requires_redmine_plugin` method (see source:/trunk/lib/redmine/plugin.rb@19983#L274). Utilisation of the method provides an easy, reliable way to create plugins that require a specific (version of a) Redmine plugin and which are setup to stop Redmine with a message about a non-supported version if the version-requirement is not met.

{{collapse(View usage examples for requires_redmine_plugin method…)

    <code class="ruby">
    # Requires a plugin named :foo version 0.7.3 or higher
    requires_redmine_plugin :foo, :version_or_higher => '0.7.3'
    requires_redmine_plugin :foo, '0.7.3'

    # Requires a specific version of a Redmine plugin
    requires_redmine_plugin :foo, :version => '0.7.3'              # 0.7.3 only
    requires_redmine_plugin :foo, :version => ['0.7.3', '0.8.0']   # 0.7.3 or 0.8.0
    </code>

\
}}

[^1]: source: message#59809
