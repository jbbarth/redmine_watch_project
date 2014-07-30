require_dependency "issue"

class Issue
  before_create :add_project_watchers_as_watchers

  def add_project_watchers_as_watchers
    self.watcher_user_ids += self.project.watcher_user_ids
  end
end
