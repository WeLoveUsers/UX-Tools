Rails.application.routes.draw do
  resources :response_sus
  resources :response_attrak_diffs
  resources :response_deeps
  resources :projects
  devise_for :users
  get 'admin', to: 'admin#index', as: 'admin_root'
  get 'admin/index'
  get 'welcome/index'
  get 'projects/index'
  get 'sample_sizes/usability_problems'
  get 'r/success', to: 'projects#response_saved', as: 'project_public_response_saved'
  get 'r/:uri_token', to: 'projects#respond', as: 'project_public_respond'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
