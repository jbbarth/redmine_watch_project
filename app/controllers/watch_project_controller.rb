class WatchProjectController < ApplicationController
  before_filter :find_project_by_project_id
  before_filter :require_member

  def watch
    @project.watcher_users << User.current
    @project.save
    redirect_back_or_default project_issues_path(@project)
  end

  def unwatch
    @project.watcher_users = @project.watcher_users - [User.current]
    @project.save
    redirect_back_or_default project_issues_path(@project)
  end

  private
  def require_member
    if !User.current.member_of?(@project)
      render_403
      return false
    end
    true
  end
end
