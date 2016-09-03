Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get '/home', to: 'welcome#index', as: 'home'

  resources :articles do
    resources :comments
  end
end
