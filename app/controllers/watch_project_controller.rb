class WatchProjectController < ApplicationController
  before_action :find_project_by_project_id
  before_action :require_member_or_watcher

  def watch
    #watch project
    @project.watcher_users << User.current
    @project.save
    #watch all open issues on project
    issue_ids = @project.issues.open.pluck(:id)
    already_watched = Watcher.where(:watchable_type => "Issue", :watchable_id => issue_ids, :user_id => User.current.id).pluck(:watchable_id)
    new_watchers = (issue_ids - already_watched).map do |id|
      { :watchable_type => "Issue", :watchable_id => id, :user_id => User.current.id }
    end
    Watcher.insert_all(new_watchers) if new_watchers.any?
    #redirect
    redirect_back_or_default project_issues_path(@project)
  end

  def unwatch
    #unwatch project
    @project.watcher_users = @project.watcher_users - [User.current]
    @project.save
    #unwatch all issues on project
    Watcher.where(:user_id => User.current.id,
                  :watchable_type => "Issue",
                  :watchable_id   => @project.issues.pluck(:id))
           .delete_all
    #redirect
    redirect_back_or_default project_issues_path(@project)
  end

  private

  def require_member_or_watcher
    if User.current.member_of?(@project) || @project.watcher_users.include?(User.current)
      true
    else
      render_403
      false
    end
  end
end
