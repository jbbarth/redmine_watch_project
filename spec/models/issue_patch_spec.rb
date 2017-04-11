require "spec_helper"
require_dependency 'redmine_watch_project/issue_patch'

describe Issue do
  fixtures :users, :roles, :projects, :projects_trackers, :members, :member_roles, :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :enabled_modules

  it "adds project watchers as watchers to new issues" do
    user = User.find(2)
    project = Project.find(1)
    #be sure that member of project(1)
    expect(project.users).to include user
    issue = Issue.new(:project_id => 1, :tracker_id => 1, :author_id => 3,
                      :status_id => 1, :priority => IssuePriority.all.first,
                      :subject => 'test_create')
    expect(issue).to be_valid
    #add user(2) as a watcher to project(1)
    project.watcher_users << user
    project.save!
    #now let's be sure user(2) gets added as a watcher automagically
    issue.save!
    expect(issue.reload.watcher_users).to include user
  end

  it "adds project watchers as watchers to edited issues" do
    user = User.find(2)
    project = Project.find(1)
    #be sure that member of project(1)
    expect(project.users).to include user
    issue = Issue.find(1) #project(1)
    #add user(2) as a watcher to project(1)
    project.watcher_users << user
    project.save!
    #now let's be sure user(2) gets added as a watcher automagically
    expect {
      issue.save!
    }.to change {
      issue.watcher_users.count
    }.by +1
  end
end
