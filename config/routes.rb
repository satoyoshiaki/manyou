Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end
