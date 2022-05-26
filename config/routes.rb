Rails.application.routes.draw do
  root   "welcome#index"
  get    "welcome/index"
  get    "welcome/dashboard"
  get    "password_resets/new"
  get    "password_resets/edit"
  get    "signup",           to: "users#new"
  post   "signup",           to: "users#create"
  get    "login",            to: "sessions#new"
  post   "login",            to: "sessions#create"
  delete "logout",           to: "sessions#destroy"
  get    "logout",           to: "sessions#destroy"
  get    "profile",          to: "users#show",      as: "profile"
  post   "leagues/:id/join", to: "leagues#join",    as: "join_league"

  resources :drivers
  resources :leagues
  resources :teams
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :league_memberships,  only: [:edit]
end
