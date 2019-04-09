Rails.application.routes.draw do
  get "welcome/index"
  get "signup", to: "users#new"
  post "signup", to: "users#create"

  resources :drivers

  resources :grids do
    resources :positions
  end

  resources :teams

  resources :users

  root "welcome#index"
end
