Rails.application.routes.draw do
  resources :response_sus
  resources :response_attrak_diffs
  resources :projects
  devise_for :users
  get 'welcome/index'
  get 'projects/index'
  get 'r/success', to: 'projects#response_saved', as: 'project_public_response_saved'
  get 'r/:uri_token', to: 'projects#respond', as: 'project_public_respond'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
