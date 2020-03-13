Rails.application.routes.draw do
  resources :app_notifications
  resources :response_sus
  resources :response_attrak_diffs
  resources :response_attrak_diff_abridgeds
  resources :response_deeps
  resources :projects
  devise_for :users
  get 'admin', to: 'admin#index', as: 'admin'
  get 'admin/index'
  get 'admin/project/:id', to: 'admin#project', as: 'admin_project'

  get 'welcome/index'
  get 'projects/index'

  get 'projects/:id/close', to: 'projects#close', as: 'close_project'
  get 'projects/:id/open', to: 'projects#open', as: 'open_project'

  get 'response_sus/recover/:id', to: 'response_sus#recover', as: 'recover_response_sus'
  get 'response_attrak_diffs/recover/:id', to: 'response_attrak_diffs#recover', as: 'recover_response_attrak_diffs'
  get 'response_attrak_diff_abridgeds/recover/:id', to: 'response_attrak_diff_abridgeds#recover', as: 'recover_response_attrak_diff_abridgeds'
  get 'response_deeps/recover/:id', to: 'response_deeps#recover', as: 'recover_response_deeps'

  get 'app_notifications/mark_as_read/:id', to: 'app_notifications#mark_as_read', as: 'mark_notification_as_read'

  get 'sample_sizes/usability_problems'
  get 'timer/index'

  get 'r/success/:locale', to: 'projects#response_saved', as: 'project_public_response_saved'
  get 'r/:uri_token', to: 'projects#respond', as: 'project_public_respond'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
