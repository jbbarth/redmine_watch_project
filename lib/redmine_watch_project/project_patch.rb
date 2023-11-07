module RedmineWatchProject
  module ProjectPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        acts_as_watchable
      end
    end
  end
end

Project.send(:include, RedmineWatchProject::ProjectPatch)
