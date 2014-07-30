require File.expand_path('../../spec_helper', __FILE__)

describe Issue do
  fixtures :users, :roles, :projects, :projects_trackers, :members, :member_roles, :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :enabled_modules

  it "adds project watchers as watchers to new issues" do
    user = User.find(2)
    project = Project.find(1)
    #be sure that member of project(1)
    project.users.should include user
    issue = Issue.new(:project_id => 1, :tracker_id => 1, :author_id => 3,
                      :status_id => 1, :priority => IssuePriority.all.first,
                      :subject => 'test_create')
    issue.should be_valid
    #add user(2) as a watcher to project(1)
    project.watcher_users << user
    project.save!
    #now let's be sure user(2) gets added as a watcher automagically
    issue.save!
    issue.reload.watcher_users.should include user
  end
end
