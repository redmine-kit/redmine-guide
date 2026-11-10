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
  # bin/screenshots runs this once per language (SCREENSHOT_LANGUAGE).
  LANGUAGES = ENV['SCREENSHOT_LANGUAGE'] ? [ENV['SCREENSHOT_LANGUAGE']] : %w[en ja]
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
      shots.each do |shot|
        take(shot)
      rescue StandardError, Minitest::Assertion => e
        failures << "#{language} #{shot[:name]}: #{e.class}: #{e.message.lines.first}"
      end
    end
    assert_empty failures, failures.join("\n")
  end

  private

  # Each shot starts in a new session, since Redmine keeps the filters of
  # the last issue query in the session.
  def take(shot)
    login(!shot[:anonymous])
    page.driver.browser.manage.window.resize_to(WIDTH, 900)
    target = instance_exec(&shot[:block])
    wait_for_page
    save(shot[:name], target)
  end

  def login(admin)
    Capybara.reset_sessions!
    log_user('admin', 'admin') if admin
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

  # A window tall enough for the context menu to open below the row clicked.
  def tall_window
    page.driver.browser.manage.window.resize_to(WIDTH, 1400)
  end

  # Uploads a file in the form, which then shows its description field. The
  # browser runs in another container, so Selenium sends it the file.
  def attach
    page.driver.browser.file_detector = ->(args) { args.first.to_s if File.exist?(args.first.to_s) }
    attach_file 'attachments[dummy][file]', Rails.root.join('test/fixtures/files/testfile.txt')
    find('.attachments_fields input.description', visible: true)
  end

  def wait_for_page
    assert page.evaluate_script('document.readyState') == 'complete'
    assert page.has_no_css?('#errorExplanation', wait: 0), 'an error page'
    page.evaluate_script('Array.from(document.images).every(function(i) { return i.complete; })')
    sleep 0.3
  end

  # Grows the window to the element, so that Chrome captures all of it, and
  # saves it at the device scale (2x). The window's inner height is less than
  # its outer height by the browser's own bars, so the window grows by those
  # too. #main fills the window otherwise, and a crop of #content would end
  # in blank space down to the window's bottom.
  def save(name, target)
    page.execute_script('document.activeElement && document.activeElement.blur && document.activeElement.blur()')
    path = File.join(ROOT, 'images', @language, "#{File.dirname(name)}/#{File.basename(name)}@2x.png")
    FileUtils.mkdir_p(File.dirname(path))
    if target == :window
      page.execute_script('window.scrollTo(0, 0)')
      page.driver.browser.save_screenshot(path)
    else
      element = target.is_a?(String) ? find(target) : target
      page.execute_script("var main = document.getElementById('main'); if (main) main.style.flexGrow = '0';")
      3.times do
        bottom = element.evaluate_script('this.getBoundingClientRect().bottom + window.scrollY')
        bars = page.evaluate_script('window.outerHeight - window.innerHeight')
        page.driver.browser.manage.window.resize_to(WIDTH, [bottom.ceil + bars + 20, 900].max)
      end
      page.execute_script('window.scrollTo(0, 0)')
      element.native.save_screenshot(path)
      height = element.evaluate_script('this.getBoundingClientRect().height')
      assert png_height(path) >= (height * 2).floor - 2, "#{name} is cut off"
    end
    assert File.size?(path), "no screenshot at #{path}"
  end

  # The height in pixels of a PNG file (from its IHDR chunk).
  def png_height(path)
    File.binread(path, 4, 20).unpack1('N')
  end

  # Data the test fixtures lack: a user waiting for activation, additional
  # email addresses, the administrator as a member with issues and a query
  # of their own, subtasks in a version, a revision associated with an
  # issue. The fixtures' texts are in Textile. The test repository's
  # committers are mapped to the fixtures' users, so that the screens show
  # their names.
  def prepare_data
    Setting.text_formatting = 'textile'
    Member.create!(project_id: 1, user_id: 1, role_ids: [1])
    IssueQuery.create!(project_id: 1, user_id: 1, name: 'My open issues', visibility: Query::VISIBILITY_PRIVATE,
                       filters: { 'status_id' => { operator: 'o', values: [''] },
                                  'assigned_to_id' => { operator: '=', values: ['me'] } })
    repository = Repository.find(10)
    repository.fetch_changesets
    repository.committer_ids = { 'jp' => 2, 'jsmith' => 2, 'maeda' => 4, 'marius.balteanu' => 4, 'schmidt' => 3 }
    # Commits in the last 12 months, in the order of their revisions, for the
    # statistics.
    repository.changesets.sort_by { |changeset| -changeset.revision.to_i }.each_with_index do |changeset, i|
      time = (i * 22).days.ago
      changeset.update_columns(committed_on: time, commit_date: time.to_date)
    end
    %w[admin.home@somenet.foo admin.mobile@somenet.foo].each do |address|
      EmailAddress.create!(user_id: 1, address: address, notify: address.include?('home'))
    end
    user = User.new(firstname: 'Emma', lastname: 'Clark', mail: 'eclark@somenet.foo', language: 'en')
    user.login = 'eclark'
    user.password = user.password_confirmation = 'eclark-password'
    user.status = User::STATUS_REGISTERED
    user.save!
    parent = Issue.generate!(project_id: 1, tracker_id: 2, subject: 'Recipe import', fixed_version_id: 3,
                             start_date: Date.current, due_date: Date.current + 20)
    [['Parse the recipe files', 0, 8], ['Map the ingredients', 6, 14], ['Import the photos', 12, 20]].each do |subject, from, to|
      Issue.generate!(project_id: 1, tracker_id: 2, subject: subject, parent_issue_id: parent.id, fixed_version_id: 3,
                      assigned_to_id: 1,
                      start_date: Date.current + from, due_date: Date.current + to)
    end
    Changeset.find(100).issues << Issue.find(1) unless Changeset.find(100).issues.include?(Issue.find(1))
  end

  # User guide

  shot('RedmineLogin/redmine-login', anonymous: true) { visit '/login'; '#login-form' }
  shot('RedmineAccounts/lost-password', anonymous: true) { visit '/login'; '#login-form' }
  shot('RedmineAccounts/register', anonymous: true) do
    Setting.self_registration = '1'
    visit '/login'
    '#account'
  end
  shot('RedmineRegister/redmine-register', anonymous: true) do
    Setting.self_registration = '1'
    visit '/account/register'
    '#content'
  end
  shot('RedmineRegister/activate-account') do
    visit '/users?set_filter=1&f[]=status&op[status]==&v[status][]=2'
    find('tr.user a.js-contextmenu').click
    find('#context-menu', visible: true)
    :window
  end

  shot('RedmineAccounts/myaccount-info') { visit '/my/account'; box(:label_information_plural) }
  shot('RedmineAccounts/myaccount-notification') { visit '/my/account'; box(:field_mail_notification) }
  shot('RedmineAccounts/myaccount-preferences') { visit '/my/account'; box(:label_preferences) }
  shot('RedmineAccounts/emails') { visit '/my/account'; '#content > .contextual a.icon-email-add' }
  shot('RedmineAccounts/myaccount-emails') do
    visit '/my/account'
    find('#content > .contextual a.icon-email-add').click
    dialog
  end
  shot('RedmineAccounts/myaccount-changepw') { visit '/my/account'; '#content > .contextual a.icon-passwd' }

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
  shot('RedmineIssueList/ext_newquery') do
    visit '/projects/ecookbook/queries/new'
    fill_in 'query_name', with: 'Open feature requests'
    uncheck 'query_default_columns'
    '#content'
  end
  shot('RedmineIssueList/custom_queries_sidebar') { visit '/projects/ecookbook/issues'; '#sidebar-wrapper' }
  shot('RedmineIssueList/sidebar') { visit '/projects/ecookbook/issues'; '#sidebar-wrapper' }
  shot('RedmineIssueList/shortcut_menu') do
    visit '/projects/ecookbook/issues'
    tall_window
    all('tr.issue')[4].find('td.status').right_click
    find('#context-menu a.submenu', text: t(:field_priority)).hover
    find('#context-menu li.folder ul', visible: true)
    :window
  end
  shot('RedmineIssueList/bulk-edit') do
    visit '/projects/ecookbook/issues'
    tall_window
    rows = all('tr.issue')
    [4, 5, 7].each { |i| rows[i].find('td.checkbox input').click }
    rows[7].find('td.status').right_click
    find('#context-menu', visible: true)
    :window
  end

  shot('RedmineIssueSummary/issue_summary') { visit '/projects/ecookbook/issues/report'; '#content' }
  shot('RedmineIssueSummary/issue_summary_version-details') { visit '/projects/ecookbook/issues/report/version'; '#content' }

  shot('RedmineIssues/RedmineEditIssue_Update_Link') { visit '/issues/1'; first('#content > .contextual') }
  shot('RedmineIssues/RedmineChangingIssueDescriptionNew') do
    visit '/issues/1'
    first('#content > .contextual a.icon-edit').click
    find('#issue_subject').find(:xpath, 'ancestor::fieldset[1]')
  end
  shot('RedmineIssues/redmine-related-issues') do
    visit '/issues/2'
    # A click before the page's scripts are ready does nothing.
    3.times do
      find('#relations a.icon-link-add').click
      break if page.has_css?('#new-relation-form', visible: true, wait: 2)
    end
    find('#new-relation-form', visible: true)
    '#relations'
  end
  shot('RedmineIssues/redmine-watchers') do
    visit '/issues/2'
    find('#watchers .contextual a').click
    dialog
  end
  shot('RedmineIssues/redmine-associated-revision') do
    visit '/issues/1?tab=changesets'
    '#history'
  end
  shot('RedmineIssues/redmine_manual_revision_issue_association') do
    visit "/projects/ecookbook/repository/10/revisions/#{Changeset.find(100).revision}"
    '#content'
  end
  shot('RedmineIssues/subtasks-list') do
    visit '/projects/ecookbook/issues?set_filter=1&f[]=fixed_version_id&op[fixed_version_id]==&v[fixed_version_id][]=3' \
          '&c[]=tracker&c[]=status&c[]=subject&c[]=parent&c[]=assigned_to&sort=parent'
    'table.list.issues'
  end
  shot('RedmineIssues/subtasks-gantt') do
    visit '/projects/ecookbook/issues/gantt?set_filter=1&f[]=fixed_version_id&op[fixed_version_id]==&v[fixed_version_id][]=3'
    '#content'
  end

  shot('RedmineTimeTracking/log_time') { visit '/issues/1/time_entries/new'; '#content' }
  shot('RedmineTimeTracking/Update_LogTime') do
    visit '/issues/1'
    first('#content > .contextual a.icon-edit').click
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
  shot('RedmineFiles/UploadFile') do
    visit '/projects/ecookbook/files/new'
    attach
    '#content'
  end
  shot('RedmineAttachedFiles/UploadFile') do
    visit '/projects/ecookbook/issues/new'
    attach
    '#attachments_form'
  end
  shot('RedmineForums/forums') { visit '/projects/ecookbook/boards'; '#content' }

  shot('RedmineWikis/wiki-toolbar') do
    # The fixtures have the administrator watch the page; the guide shows Watch.
    Watcher.where(user_id: 1, watchable_type: 'WikiPage', watchable_id: 1).delete_all
    visit '/projects/ecookbook/wiki'
    '#content > .contextual'
  end
  shot('RedmineWikis/history') { visit '/projects/ecookbook/wiki/CookBook_documentation/history'; '#content' }
  shot('RedmineWikis/page_version') { visit '/projects/ecookbook/wiki/CookBook_documentation/2'; '#content' }

  shot('RedmineRepository/repository') { visit '/projects/ecookbook/repository'; '#content' }
  shot('RedmineRepositoryStatistics/graphs') { visit '/projects/ecookbook/repository/10/statistics'; '#content' }
  shot('RedmineProjectSettings/project-settings_information-tab') { visit '/projects/ecookbook/settings'; '#content' }

  shot('RedmineSearch/SimpleSearch') { visit '/projects/ecookbook'; '#quick-search' }
  shot('RedmineSearch/SearchProjects') do
    visit '/projects/ecookbook'
    find('#project-jump .drdn-trigger').click
    find('#project-jump .drdn-content', visible: true)
    :window
  end
  shot('RedmineSearch/AdvancedSearch') { visit '/projects/ecookbook/search?q=recipe'; '#search-form' }
  shot('RedmineSearch/Results') { visit '/projects/ecookbook/search?q=recipe'; '#content' }
  shot('RedmineSearch/Searchable') { visit '/custom_fields/2/edit'; parent('#custom_field_searchable') }

  # Administrator guide

  shot('RedmineAdminInformation/admin-infomation') { visit '/admin/info'; '#content' }
  shot('RedmineProjects/project_list') { visit '/admin/projects'; '#content' }
  shot('RedmineProjects/project_copy') do
    visit '/projects/ecookbook/copy'
    first("input[name='only[]']").find(:xpath, 'ancestor::fieldset[1]')
  end
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
    { 'assigned_to_id' => 'required', 'category_id' => 'readonly', 'due_date' => 'required' }.each do |field, value|
      find("select[name='permissions[1][#{field}]'] option[value='#{value}']").select_option
    end
    '#content'
  end
  shot('RedmineEnumerations/enumerations') { visit '/enumerations'; '#content' }
end
