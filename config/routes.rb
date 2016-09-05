Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'
  get 'welcome/index'
  get '/home', to: 'welcome#index', as: 'home'

  resources :categories
  resources :articles do
    resources :comments
  end
end
