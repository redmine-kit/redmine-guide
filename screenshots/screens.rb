# frozen_string_literal: true

require '/redmine/test/application_system_test_case'

# The guide's screenshots (bin/screenshots). Each shot is named after the
# image it replaces (images/<page>/<file> becomes
# images/<lang>/<page>/<file without @2x and extension>@2x.png) and shows the
# same screen in Redmine 7.0.3, in every language, with Redmine's test data.
# A shot's block opens the screen and returns what to capture: a CSS
# selector, a Capybara element, or :window for the whole window.
class GuideScreenshots < ApplicationSystemTestCase
  ROOT = File.expand_path('..', __dir__)
  LANGUAGES = %w[en ja].freeze
  WIDTH = 1280

  fixtures :all

  @shots = []
  class << self
    attr_reader :shots

    # anonymous: taken logged out.
    def shot(name, anonymous: false, &block)
      @shots << { name: name, anonymous: anonymous, block: block }
    end
  end

  def setup
    set_fixtures_attachments_directory
    prepare_data
  end

  test 'screenshots' do
    only = ENV['ONLY'].presence
    shots = self.class.shots.select { |shot| only.nil? || shot[:name].match?(only) }
    failures = []
    LANGUAGES.each do |language|
      @language = language
      Setting.default_language = language
      Setting.force_default_language_for_anonymous = '1'
      User.find(1).update!(language: language)
      @logged_in = nil
      shots.each do |shot|
        take(shot)
      rescue StandardError, Minitest::Assertion => e
        failures << "#{language} #{shot[:name]}: #{e.class}: #{e.message.lines.first}"
      end
    end
    assert_empty failures, failures.join("\n")
  end

  private

  def take(shot)
    login(!shot[:anonymous])
    page.driver.browser.manage.window.resize_to(WIDTH, 900)
    target = instance_exec(&shot[:block])
    wait_for_page
    save(shot[:name], target)
  end

  def login(admin)
    return if @logged_in == admin

    Capybara.reset_sessions!
    log_user('admin', 'admin') if admin
    @logged_in = admin
  end

  def t(key)
    ::I18n.t(key, locale: @language)
  end

  # The fieldset whose legend is the label.
  def box(key)
    find(:xpath, "//fieldset[legend[normalize-space(.)=#{t(key).to_json}]]")
  end

  def parent(selector)
    find(selector).find(:xpath, '..')
  end

  def dialog
    find('.ui-dialog', visible: true)
  end

  def wait_for_page
    assert page.evaluate_script('document.readyState') == 'complete'
    page.evaluate_script('Array.from(document.images).every(function(i) { return i.complete; })')
    sleep 0.3
  end

  # Grows the window to the element, so that Chrome captures all of it, and
  # saves it at the device scale (2x).
  def save(name, target)
    page.execute_script('document.activeElement && document.activeElement.blur && document.activeElement.blur()')
    path = File.join(ROOT, 'images', @language, "#{File.dirname(name)}/#{File.basename(name)}@2x.png")
    FileUtils.mkdir_p(File.dirname(path))
    if target == :window
      page.execute_script('window.scrollTo(0, 0)')
      page.driver.browser.save_screenshot(path)
    else
      element = target.is_a?(String) ? find(target) : target
      2.times do
        bottom = element.evaluate_script('this.getBoundingClientRect().bottom')
        page.driver.browser.manage.window.resize_to(WIDTH, [bottom.ceil + 100, 900].max)
      end
      page.execute_script('window.scrollTo(0, 0)')
      element.native.save_screenshot(path)
    end
    assert File.size?(path), "no screenshot at #{path}"
  end

  # Data the test fixtures lack: a user waiting for activation, subtasks in a
  # version, a revision associated with an issue.
  def prepare_data
    user = User.new(firstname: 'Emma', lastname: 'Clark', mail: 'eclark@somenet.foo', language: 'en')
    user.login = 'eclark'
    user.password = user.password_confirmation = 'eclark-password'
    user.status = User::STATUS_REGISTERED
    user.save!
    parent = Issue.generate!(project_id: 1, tracker_id: 2, subject: 'Recipe import', fixed_version_id: 2,
                             start_date: Date.current, due_date: Date.current + 20)
    [['Parse the recipe files', 0, 8], ['Map the ingredients', 6, 14], ['Import the photos', 12, 20]].each do |subject, from, to|
      Issue.generate!(project_id: 1, tracker_id: 2, subject: subject, parent_issue_id: parent.id, fixed_version_id: 2,
                      start_date: Date.current + from, due_date: Date.current + to)
    end
    Changeset.find(100).issues << Issue.find(1) unless Changeset.find(100).issues.include?(Issue.find(1))
  end

  # User guide

  shot('RedmineLogin/redmine-login', anonymous: true) { visit '/login'; '#login-form' }
  shot('RedmineAccounts/lost-password', anonymous: true) { visit '/account/lost_password'; '#content' }
  shot('RedmineAccounts/register', anonymous: true) do
    Setting.self_registration = '1'
    visit '/account/register'
    '#content'
  end
  shot('RedmineRegister/redmine-register', anonymous: true) do
    Setting.self_registration = '1'
    visit '/account/register'
    '#content'
  end
  shot('RedmineRegister/activate-account') { visit '/users?set_filter=1&f[]=status&op[status]==&v[status][]=2'; '#content' }

  shot('RedmineAccounts/myaccount-info') { visit '/my/account'; box(:label_information_plural) }
  shot('RedmineAccounts/myaccount-notification') { visit '/my/account'; box(:field_mail_notification) }
  shot('RedmineAccounts/myaccount-preferences') { visit '/my/account'; box(:label_preferences) }
  shot('RedmineAccounts/emails') { visit '/my/account'; '#content > .contextual' }
  shot('RedmineAccounts/myaccount-emails') do
    visit '/my/account'
    find('#content > .contextual a.icon-email-add').click
    dialog
  end
  shot('RedmineAccounts/myaccount-changepw') { visit '/my/password'; '#content' }

  shot('RedmineMyPage/my-page') { visit '/my/page'; '#content' }
  shot('RedmineProjectOverview/redmine-project-overview') { visit '/projects/ecookbook'; :window }
  shot('RedmineProjectActivity/projects_redmine_activity') do
    visit "/projects/ecookbook/activity?from=#{Date.new(2006, 7, 20)}"
    '#main'
  end

  shot('RedmineIssueList/issuelist_overview') { visit '/projects/ecookbook/issues'; :window }
  shot('RedmineIssueList/applied_issuelist_filters') do
    visit '/projects/ecookbook/issues?set_filter=1&f[]=status_id&op[status_id]=o&f[]=tracker_id&op[tracker_id]==&v[tracker_id][]=1'
    '#query_form'
  end
  shot('RedmineIssueList/redmine-multiple-selection') do
    visit '/projects/ecookbook/issues?set_filter=1&f[]=status_id&op[status_id]=o&f[]=tracker_id&op[tracker_id]==&v[tracker_id][]=1&v[tracker_id][]=2'
    '#filters'
  end
  shot('RedmineIssueList/ext_newquery') { visit '/projects/ecookbook/queries/new'; '#content' }
  shot('RedmineIssueList/custom_queries_sidebar') { visit '/projects/ecookbook/issues'; '#sidebar' }
  shot('RedmineIssueList/sidebar') { visit '/projects/ecookbook/issues'; '#sidebar' }
  shot('RedmineIssueList/shortcut_menu') do
    visit '/projects/ecookbook/issues'
    find('tr#issue-1 td.subject').right_click
    find('#context-menu', visible: true)
    :window
  end
  shot('RedmineIssueList/bulk-edit') do
    visit '/projects/ecookbook/issues'
    find('tr#issue-1 input[type=checkbox]').click
    find('tr#issue-2 input[type=checkbox]').click
    find('tr#issue-2 td.subject').right_click
    find('#context-menu', visible: true)
    :window
  end

  shot('RedmineIssueSummary/issue_summary') { visit '/projects/ecookbook/issues/report'; '#content' }
  shot('RedmineIssueSummary/issue_summary_version-details') { visit '/projects/ecookbook/issues/report/version'; '#content' }

  shot('RedmineIssues/RedmineEditIssue_Update_Link') { visit '/issues/1'; '#content > .contextual' }
  shot('RedmineIssues/RedmineChangingIssueDescriptionNew') { visit '/issues/1'; 'div.issue div.description' }
  shot('RedmineIssues/redmine-related-issues') { visit '/issues/2'; '#relations' }
  shot('RedmineIssues/redmine-watchers') { visit '/issues/2'; '#watchers' }
  shot('RedmineIssues/redmine-associated-revision') do
    visit '/issues/1?tab=changesets'
    '#history'
  end
  shot('RedmineIssues/redmine_manual_revision_issue_association') do
    visit "/projects/ecookbook/repository/revisions/#{Changeset.find(100).revision}"
    '#content'
  end
  shot('RedmineIssues/subtasks-list') do
    visit '/projects/ecookbook/issues?set_filter=1&f[]=fixed_version_id&op[fixed_version_id]==&v[fixed_version_id][]=2&sort=id'
    '#content'
  end
  shot('RedmineIssues/subtasks-gantt') do
    visit '/projects/ecookbook/issues/gantt?set_filter=1&f[]=fixed_version_id&op[fixed_version_id]==&v[fixed_version_id][]=2'
    '#content'
  end

  shot('RedmineTimeTracking/log_time') { visit '/issues/1/time_entries/new'; '#content' }
  shot('RedmineTimeTracking/Update_LogTime') do
    visit '/issues/1'
    find('#content > .contextual a.icon-edit').click
    parent('#time_entry_hours').find(:xpath, 'ancestor::fieldset[1]')
  end
  shot('RedmineTimelogDetails/SearchTimelog') { visit '/projects/ecookbook/time_entries'; '#query_form' }
  shot('RedmineTimelogDetails/TimeLogDetails') { visit '/projects/ecookbook/time_entries'; '#content' }
  shot('RedmineTimelogReport/SearchTimelog') { visit '/projects/ecookbook/time_entries/report'; '#query_form' }
  shot('RedmineTimelogReport/TimeLogReport') do
    visit '/projects/ecookbook/time_entries/report?criteria[]=issue&criteria[]=activity&columns=year'
    '#content'
  end

  shot('RedmineRoadmap/roadmap-default') { visit '/projects/ecookbook/roadmap'; '#main' }
  shot('RedmineVersion/version') { visit '/versions/2'; '#content' }
  shot('RedmineGantt/gantt') { visit '/projects/ecookbook/issues/gantt'; '#content' }
  shot('RedmineCalendar/calendar') { visit '/projects/ecookbook/issues/calendar'; '#content' }
  shot('RedmineNews/news_list') { visit '/projects/ecookbook/news'; '#content' }
  shot('RedmineDocuments/Documents') { visit '/projects/ecookbook/documents'; '#content' }
  shot('RedmineDocuments/NewDocument') { visit '/projects/ecookbook/documents/new'; '#content' }
  shot('RedmineFiles/files') { visit '/projects/ecookbook/files'; '#content' }
  shot('RedmineFiles/UploadFile') { visit '/projects/ecookbook/files/new'; '#content' }
  shot('RedmineAttachedFiles/UploadFile') { visit '/projects/ecookbook/issues/new'; '#attachments_form' }
  shot('RedmineForums/forums') { visit '/projects/ecookbook/boards'; '#content' }

  shot('RedmineWikis/wiki-toolbar') { visit '/projects/ecookbook/wiki'; '#content > .contextual' }
  shot('RedmineWikis/history') { visit '/projects/ecookbook/wiki/CookBook_documentation/history'; '#content' }
  shot('RedmineWikis/page_version') { visit '/projects/ecookbook/wiki/CookBook_documentation/2'; '#content' }

  shot('RedmineRepository/repository') { visit '/projects/ecookbook/repository'; '#content' }
  shot('RedmineRepositoryStatistics/graphs') { visit '/projects/ecookbook/repository/stats'; '#content' }
  shot('RedmineProjectSettings/project-settings_information-tab') { visit '/projects/ecookbook/settings'; '#content' }

  shot('RedmineSearch/SimpleSearch') { visit '/projects/ecookbook'; '#quick-search' }
  shot('RedmineSearch/SearchProjects') do
    visit '/projects/ecookbook'
    find('#project-jump .drdn-trigger').click
    find('#project-jump .drdn-content', visible: true)
    '#header'
  end
  shot('RedmineSearch/AdvancedSearch') { visit '/projects/ecookbook/search?q=recipe'; '#search-form' }
  shot('RedmineSearch/Results') { visit '/projects/ecookbook/search?q=recipe'; '#content' }
  shot('RedmineSearch/Searchable') { visit '/custom_fields/2/edit'; parent('#custom_field_searchable') }

  # Administrator guide

  shot('RedmineAdminInformation/admin-infomation') { visit '/admin/info'; '#content' }
  shot('RedmineProjects/project_list') { visit '/admin/projects'; '#content' }
  shot('RedmineProjects/project_copy') { visit '/projects/ecookbook/copy'; '#content' }
  shot('RedmineUsers/users-list') { visit '/users'; '#content' }
  shot('RedmineGroups/RedmineMembersToGroup') { visit '/groups/10/edit?tab=users'; '#content' }
  shot('RedmineGroups/RedmineMemberToGroupNew') do
    visit '/groups/10/edit?tab=users'
    find('#tab-content-users a.icon-add').click
    dialog
  end
  shot('RedmineGroups/RedmineGroupToProjects') { visit '/groups/10/edit?tab=memberships'; '#content' }
  shot('RedmineGroups/RedmineGroupToProjectNew') do
    visit '/groups/10/edit?tab=memberships'
    find('#tab-content-memberships a.icon-add').click
    dialog
  end
  shot('RedmineRoles/roles') { visit '/roles'; '#content' }
  shot('RedmineIssueTrackingSetup/tracker_config') { visit '/trackers/1/edit'; '#content' }
  shot('RedmineIssueTrackingSetup/workflow_example') { visit '/workflows/edit?role_id=1&tracker_id=1'; '#content' }
  shot('RedmineIssueTrackingSetup/workflow_fields_permissions_closeup') do
    visit '/workflows/permissions?role_id=1&tracker_id=1'
    '#content'
  end
  shot('RedmineEnumerations/enumerations') { visit '/enumerations'; '#content' }
end
