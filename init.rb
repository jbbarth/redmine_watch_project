Redmine::Plugin.register :redmine_watch_project do
  name 'Redmine Watch Project plugin'
  author 'Jean-Baptiste BARTH'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_watch_project'
  author_url 'jeanbaptiste.barth@gmail.com'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.1'
end

Rails.application.config.to_prepare do
  require_dependency 'redmine_watch_project/issue_patch'
  require_dependency 'redmine_watch_project/project_patch'
end
