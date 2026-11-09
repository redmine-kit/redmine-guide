# frozen_string_literal: true

# The Redmine guide as Markdown (en/, ja/, images/, index.yml, map.yml), for
# redmine_help (https://github.com/redmine-kit/redmine_help). The gem holds
# files only; redmine_help finds them through Gem.loaded_specs.
module RedmineGuide
  VERSION = '0.1.0'
  ROOT = File.expand_path('..', __dir__)
end
