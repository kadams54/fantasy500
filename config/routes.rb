Rails.application.routes.draw do
  get "welcome/index"

  resources :drivers

  resources :grids do
    resources :positions
  end

  root "welcome#index"
end
