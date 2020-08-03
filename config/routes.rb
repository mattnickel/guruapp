Rails.application.routes.draw do
  
  resources :emails
  resources :users
  resources :sessions
  resources :welcome, path: "home"
  resources :users, only: [:show]

  get 'sessions/new'
  get 'sessions/index'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  # get 'users/view'


  get 'welcome/index'
  get 'welcome/download', to: 'welcome#download', as: 'download'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # root :to => "users#new"
 

  resources :training_modules do
    resources :comments
  end

  root 'welcome#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount API::Base, at: "/"
end
end
