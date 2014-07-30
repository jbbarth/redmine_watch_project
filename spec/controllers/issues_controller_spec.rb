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
    let(:project) { Project.find(5) }

    describe "POST watch" do
      it "adds current user to project's watchers" do
        session[:user_id] = 1
        expect {
          post :watch, :project_id => project.id
        }.to change {
          Watcher.where(:watchable_type => "Project").count
        }.by 1
        response.should redirect_to(project_issues_path(project))
      end

      it "watches directly all (open) issues in the project" do
        session[:user_id] = 1
        expect {
          post :watch, :project_id => project.id
        }.to change {
          Watcher.where(:watchable_type => "Issue").count
        }.by project.issues.open.count
      end
    end

    describe "DELETE unwatch" do
      it "removes current user from project's watchers" do
        project.watcher_users << User.find(1)
        project.save!
        session[:user_id] = 1
        expect {
          delete :unwatch, :project_id => project.id
        }.to change {
          Watcher.where(:watchable_type => "Project").count
        }.by -1
        response.should redirect_to(project_issues_path(project))
      end

      it "unwatches directly all issues in the project" do
        project.issues.each do |issue|
          Watcher.create(:watchable_type => "Issue", :watchable_id => issue.id, :user_id => 1)
        end
        session[:user_id] = 1
        expect {
          delete :unwatch, :project_id => project.id
        }.to change {
          Watcher.where(:watchable_type => "Issue").count
        }.by -project.issues.count
      end

    end
  end
end
