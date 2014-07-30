require_relative '../spec_helper'

describe WatchProjectController do
  fixtures :users, :roles, :projects, :projects_trackers, :members, :member_roles, :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :enabled_modules

  before do
    session[:user_id] = 1 #admin (== worst case scenario for 1, but shouldnt be authorized anyway!)
  end

  context "unauthorized" do
    it "refuses access to non-members" do
      session[:user_id] = 1
      post :watch, :project_id => 2
      response.status.should == 403
    end
  end

  context "authorized" do
    describe "POST watch" do
      it "adds current user to project's watchers" do
        project = Project.find(5)
        session[:user_id] = 1
        expect {
          post :watch, :project_id => project.id
        }.to change {
          Watcher.count
        }.by 1
        response.should redirect_to(project_issues_path(project))
      end
    end

    describe "DELETE unwatch" do
      it "removes current user from project's watchers" do
        project = Project.find(5)
        project.watcher_users << User.find(1)
        project.save!
        session[:user_id] = 1
        expect {
          delete :unwatch, :project_id => project.id
        }.to change {
          Watcher.count
        }.by -1
        response.should redirect_to(project_issues_path(project))
      end
    end
  end
end
