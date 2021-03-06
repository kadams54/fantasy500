Rails.application.routes.draw do
  root   "welcome#index"
  get    "welcome/index"
  get    "welcome/dashboard"
  get    "password_resets/new"
  get    "password_resets/edit"
  get    "signup",      to: "users#new"
  post   "signup",      to: "users#create"
  get    "login",       to: "sessions#new"
  post   "login",       to: "sessions#create"
  delete "logout",      to: "sessions#destroy"

  resources :drivers
  resources :grids do
    resources :positions
  end
  resources :leagues
  resources :teams
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :league_memberships,  only: [:edit]
end
