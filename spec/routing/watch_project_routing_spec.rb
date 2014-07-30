require_relative "../spec_helper"

describe WatchProjectController do
  describe "routing" do
    it "routes to #watch" do
      post("/projects/foo/watch").should route_to("watch_project#watch", :project_id => "foo")
    end

    it "routes to #unwatch" do
      delete("/projects/foo/watch").should route_to("watch_project#unwatch", :project_id => "foo")
    end
  end
end
