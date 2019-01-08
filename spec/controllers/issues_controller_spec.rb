require "spec_helper"

describe WatchProjectController do
  fixtures :users, :roles, :projects, :projects_trackers, :members, :member_roles, :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :enabled_modules

  before do
    session[:user_id] = 1 #admin (== worst case scenario for 1, but shouldnt be authorized anyway!)
  end

  context "unauthorized" do
    it "refuses access to non-members" do
      session[:user_id] = 1
      post :watch, params: {:project_id => 2}
      expect(response.status).to eq 403
    end
  end

  context "authorized" do
    let(:user) { User.find(1) }
    let(:project) { Project.find(5) }

    before do
      session[:user_id] = user.id
    end

    describe "POST watch" do
      it "adds current user to project's watchers" do
        expect {
          post :watch, params: {:project_id => project.id}
        }.to change {
          Watcher.where(:watchable_type => "Project").count
        }.by 1
        expect(response).to redirect_to(project_issues_path(project))
      end

      it "watches directly all (open) issues in the project" do
        expect {
          post :watch, params: {:project_id => project.id}
        }.to change {
          Watcher.where(:watchable_type => "Issue").count
        }.by project.issues.open.count
      end
    end

    describe "DELETE unwatch" do
      it "removes current user from project's watchers" do
        project.watcher_users << user
        project.save!
        expect {
          delete :unwatch, params: {:project_id => project.id}
        }.to change {
          Watcher.where(:watchable_type => "Project").count
        }.by -1
        expect(response).to redirect_to(project_issues_path(project))
      end

      it "unwatches directly all issues in the project" do
        project.issues.each do |issue|
          Watcher.create(:watchable_type => "Issue", :watchable_id => issue.id, :user_id => 1)
        end
        expect {
          delete :unwatch, params: {:project_id => project.id}
        }.to change {
          Watcher.where(:watchable_type => "Issue").count
        }.by -project.issues.count
      end
    end
  end
end
