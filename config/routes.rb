Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations, :passwords]
  
  devise_scope :user do
    # sessions
    get    'login',  to: 'users/sessions#new',     as: :new_user_session
    post   'login',  to: 'users/sessions#create',  as: :user_session
    get 'logout', to: 'users/sessions#destroy', as: :logout
    # registrations
    put    '/account',  to: 'users/registrations#update'
    delete '/account',  to: 'users/registrations#destroy'
    post   '/account',  to: 'users/registrations#create'
    get    '/register', to: 'users/registrations#new',    as: :new_user_registration
    get    '/account',  to: 'users/registrations#edit',   as: :edit_user_registration
    patch  '/account',  to: 'users/registrations#update', as: :user_registration
    get    '/account/cancel', to: 'users/registrations#cancel', as: :cancel_user_registration# passwords 
    # passwords
    get   'new-pass',  to: 'users/passwords#new',    as: :new_user_password
    get   'edit-pass', to: 'users/passwords#edit',   as: :edit_user_password
    patch 'edit-pass', to: 'users/passwords#update', as: :user_password
    # post  'new-pass',  to: 'users/passwords#create', as: :user_password
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :videos
  resources :emails
  resources :users
  # resources :sessions
  resources :welcome, path: "home"
  resources :users, only: [:show]

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'welcome/index'
  get 'welcome/download', to: 'welcome#download', as: 'download'


 

  resources :training_modules do
    resources :comments
  end

  root to: 'welcome#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount API::Base, at: "/"
  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      devise_scope :user do
        post "signup", to: "registrations#create"
        post "login", to: "sessions#create"
        post "logout", to: "sessions#destroy"
      end
    end
  end

end
