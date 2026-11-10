# frozen_string_literal: true

# The guide's content as a gem, published to GitHub Packages
# (.github/workflows/gem.yml), for redmine_help.
Gem::Specification.new do |spec|
  spec.name = 'redmine-guide'
  spec.version = File.read(File.join(__dir__, 'lib/redmine-guide.rb'))[/VERSION = '([^']+)'/, 1]
  spec.summary = "The Redmine guide as Markdown, with translations, for redmine_help"
  spec.authors = ['Redmine Kit']
  # The tools (lib/) are GPL-2.0-or-later; the translations, the updates for
  # Redmine 7.0.3 and the retaken screenshots are CC-BY-SA-4.0; the text and
  # images from redmine.org state no license (README.md, "License").
  spec.licenses = ['GPL-2.0-or-later', 'CC-BY-SA-4.0']
  spec.homepage = 'https://github.com/redmine-kit/redmine-guide'
  spec.required_ruby_version = '>= 3.1'
  spec.files = Dir['{LICENSE,README.md,index.yml,map.yml}', '{LICENSES,en,ja,images,lib}/**/*']
  spec.metadata['github_repo'] = 'ssh://github.com/redmine-kit/redmine-guide'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
