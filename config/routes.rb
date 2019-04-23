Rails.application.routes.draw do
  root   "welcome#index"
  get    "welcome/index"
  get    "signup", to: "users#new"
  post   "signup", to: "users#create"
  get    "login", to: "sessions#new"
  post   "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :drivers
  resources :grids do
    resources :positions
  end
  resources :teams
  resources :users
end
