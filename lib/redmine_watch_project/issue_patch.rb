module RedmineWatchProject
  module IssuePatch

    def self.included(base)
      base.class_eval do
        before_save :add_project_watchers_as_watchers
      end
    end

    def add_project_watchers_as_watchers
      # exclude locked users and members that can't view all issues
      project.watcher_users.active.each do |user|
        if user.roles_for_project(project).any? { |role| role.allowed_to?(:view_issues) && role.issues_visibility != 'own' }
          watcher_users << user
        end
      end
    end
  end
end

Issue.send(:include, RedmineWatchProject::IssuePatch)
