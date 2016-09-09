Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'
  get 'welcome/index'
  get '/home', to: 'welcome#index', as: 'home'

  post 'welcome/event', to: 'welcome#add_google_calendar_event'

  resources :categories
  resources :articles do
    resources :comments, only: [:create, :destroy]
  end
end
