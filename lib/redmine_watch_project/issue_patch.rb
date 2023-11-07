module RedmineWatchProject
  module IssuePatch

    def self.included(base) # :nodoc:
      base.class_eval do
        before_save :add_project_watchers_as_watchers
      end
    end

    def add_project_watchers_as_watchers
      project_watchers = User.where(id: self.project.watcher_user_ids).active # exclude locked users
      self.watcher_user_ids += project_watchers.map(&:id)
    end
  end
end

Issue.send(:include, RedmineWatchProject::IssuePatch)
