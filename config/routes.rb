Rails.application.routes.draw do
  get 'welcome/index'

  resources :drivers

  root 'welcome#index'
end
