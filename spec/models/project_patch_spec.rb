require File.expand_path('../../spec_helper', __FILE__)

describe Project do
  it "is watchable" do
    Project.new.methods.should include :watcher_users
  end
end
