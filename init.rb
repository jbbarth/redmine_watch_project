Redmine::Plugin.register :redmine_watch_project do
  name 'Redmine Watch Project plugin'
  author 'Jean-Baptiste BARTH'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_watch_project'
  author_url 'jeanbaptiste.barth@gmail.com'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.2' if Rails.env.test?
  requires_redmine_plugin :redmine_base_deface, :version_or_higher => '0.0.1'
end

class ModelHook < Redmine::Hook::Listener
  def after_plugins_loaded(_context = {})
    require_relative 'lib/redmine_watch_project/issue_patch' unless Rails.env.test?
    require_relative 'lib/redmine_watch_project/project_patch'
  end
end
