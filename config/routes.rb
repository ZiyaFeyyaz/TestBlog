Rails.application.routes.draw do
  resources :articles
  root 'welcome#index'
  get 'welcome/index'
  get '/home', to: 'welcome#index', as: 'home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
