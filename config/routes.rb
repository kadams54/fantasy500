Rails.application.routes.draw do
  get "welcome/index"
  get "signup", to: 'users#new'

  resources :drivers

  resources :grids do
    resources :positions
  end

  resources :teams

  root "welcome#index"
end
