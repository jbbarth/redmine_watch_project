require_dependency "issue"

class Issue
  before_save :add_project_watchers_as_watchers

  def add_project_watchers_as_watchers
    project_watchers = User.where(id: self.project.watcher_user_ids).active # exclude locked users
    self.watchers |= project_watchers
  end
end
