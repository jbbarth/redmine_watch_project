Deface::Override.new :virtual_path  => "issues/index",
                     :name          => "add-watch-link-to-issues-list",
                     :insert_top    => "div.contextual",
                     :partial       => "redmine_watch_project/issues_watch_link"
