# frozen_string_literal: true

# The guide's content as a gem, published to GitHub Packages
# (.github/workflows/gem.yml), for redmine_help.
Gem::Specification.new do |spec|
  spec.name = 'redmine-guide'
  spec.version = File.read(File.join(__dir__, 'lib/redmine-guide.rb'))[/VERSION = '([^']+)'/, 1]
  spec.summary = "The Redmine guide as Markdown, with translations, for redmine_help"
  spec.authors = ['Redmine Kit']
  spec.license = 'GPL-2.0-or-later'
  spec.homepage = 'https://github.com/redmine-kit/redmine-guide'
  spec.required_ruby_version = '>= 3.1'
  spec.files = Dir['{LICENSE,index.yml,map.yml}', '{en,ja,images,lib}/**/*']
  spec.metadata['github_repo'] = 'ssh://github.com/redmine-kit/redmine-guide'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
