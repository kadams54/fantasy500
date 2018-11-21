Rails.application.routes.draw do
  get "welcome/index"

  resources :drivers do
    resources :positions
  end

  root "welcome#index"
end
