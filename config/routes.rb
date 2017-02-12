Rails.application.routes.draw do
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
  get 'sample_sizes/usability_problems'
  get 'timer/index'
  get 'r/success', to: 'projects#response_saved', as: 'project_public_response_saved'
  get 'r/:uri_token', to: 'projects#respond', as: 'project_public_respond'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
