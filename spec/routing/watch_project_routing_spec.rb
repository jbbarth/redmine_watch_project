require "spec_helper"

describe WatchProjectController do
  describe "routing" do
    it "routes to #watch" do
      expect(post("/projects/foo/watch")).to route_to("watch_project#watch", :project_id => "foo")
    end

    it "routes to #unwatch" do
      expect(delete("/projects/foo/watch")).to route_to("watch_project#unwatch", :project_id => "foo")
    end
  end
end
