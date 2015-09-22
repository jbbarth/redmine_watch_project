require "spec_helper"

describe "issues/index.html.erb", type: :view do
  let(:project) { Project.find(5) }
  let(:user) { User.find(1) } #member of project(5)

  before do
    User.current = user
    assign(:query, IssueQuery.new)
    assign(:issues, [])
    view.extend RoutesHelper
    view.extend QueriesHelper
  end

  it "doesn't contain 'watch' or 'unwatch' links when not inside a project" do
    render
    assert_select "div.contextual>a.icon-fav", :count => 0
    assert_select "div.contextual>a.icon-fav-off", :count => 0
  end

  it "contains an 'unwatch' link for the project if watching" do
    allow(project).to receive(:watcher_users).and_return([])
    assign(:project, project)
    render
    assert_select "div.contextual>a.icon-fav-off", :text => "Watch"
  end

  it "contains an 'watch' link for the project if not watching" do
    allow(project).to receive(:watcher_users).and_return([User.current])
    assign(:project, project)
    render
    assert_select "div.contextual>a.icon-fav", :text => "Unwatch"
  end
end
