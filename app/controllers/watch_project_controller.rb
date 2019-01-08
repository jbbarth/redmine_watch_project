class WatchProjectController < ApplicationController
  before_action :find_project_by_project_id
  before_action :require_member

  def watch
    #watch project
    @project.watcher_users << User.current
    @project.save
    #watch all open issues on project
    issue_ids = @project.issues.open.map(&:id)
    already_watched = Watcher.where(:watchable_type => "Issue", :watchable_id => issue_ids, :user_id => User.current.id).pluck(:id)
    (issue_ids - already_watched).each do |id|
      Watcher.create(:watchable_type => "Issue",
                     :watchable_id   => id,
                     :user_id        => User.current.id)
    end
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
  def require_member
    if !User.current.member_of?(@project)
      render_403
      return false
    end
    true
  end
end
