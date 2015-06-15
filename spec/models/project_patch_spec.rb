require "spec_helper"

describe Project do
  it "is watchable" do
    expect(Project.new.methods).to include :watcher_users
  end
end
