Rails.application.routes.draw do
  get "welcome/index"

  resources :drivers

  resources :grids do
    resources :positions
  end

  resources :teams

  root "welcome#index"
end
