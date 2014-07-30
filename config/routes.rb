RedmineApp::Application.routes.draw do
  post "projects/:project_id/watch", :to => "watch_project#watch", :as => "watch_project"
  delete "projects/:project_id/watch", :to => "watch_project#unwatch", :as => "unwatch_project"
end
