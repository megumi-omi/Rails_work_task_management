Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only:[:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  resources :labels
  resources :labellings, only:[:create, :destroy]
end
