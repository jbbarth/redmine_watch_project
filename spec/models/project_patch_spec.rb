require "spec_helper"

describe Project do
  it "is watchable" do
    Project.new.methods.should include :watcher_users
  end
end
