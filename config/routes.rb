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
    put 'users/:id', to: 'users/users#update', as: :update_user
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :videos
  resources :emails
  resources :users
  resources :viewings
  resources :post_bumps
  resources :welcome, path: "home"
  
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
        put "users", to: "users#update"
        get "social_posts", to: "social_posts#get"
        post "social_posts", to: "social_posts#post"
        get "social_posts", to: "social_posts/recent#get"
        get "post_bumps", to: "post_bumps#get"
        post "post_bumps", to: "post_bumps#create"
        put "post_bumps", to: "post_bumps#update"
      end
    end
  end

end
