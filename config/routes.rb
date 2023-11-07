Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create, :show]
end
