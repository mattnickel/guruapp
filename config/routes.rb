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
    post 'password/forgot', to: 'password#forgot'
    post 'password/reset', to: 'password#reset'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :videos
  resources :emails
  resources :users
  resources :viewings
  resources :post_bumps
  resources :welcome, path: "home"
  resources :support_messages_controller
  resources :category
  resources :bad_posts
  resources :blocked_user
  resources :pages
  resources :comments
  resources :training_modules
  

                                                                                                                                 
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'my_channel_view', to: 'my_channel_view#index', as: 'mychannelview'
  get 'messaging', to: 'messaging#index', as: 'coachmessagingview' 
  get 'welcome/index'
  get 'welcome/download', to: 'welcome#download', as: 'download'
  get 'privacy', to: 'welcome#privacy', as: 'privacy'

  root to: 'welcome#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount API::Base, at: "/"
  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      devise_scope :user do
        get "passwords", to: "passwords#forgot"
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
        post "support", to: "support_messages#post"
        get "videos/category", to: "videos/category#get"
        post "videos", to: "videos#post"
        get "categories", to: "category#get"
        post "bad_posts", to: "bad_posts#create"
        post "blocked_users", to: "blocked_users#create"
        post "comments/new", to: "comments#post"
        post "groups", to: "groups#post"
        post "groups", to: "groups#put"
        # get "social_attempts", to: "social_attempts#get"
        # post "social_attempts", to: "social_attempts#post"
      end

      scope :social_attempts do
        get "social_attempts", to: "social_attempts#get"
        post "social_attempts", to: "social_attempts#post"
      end

      scope :game_scores do
        get "game_scores", to: "game_scores#get"
        post "game_scores", to: "game_scores#post"
        put "game_scores", to: "game_scores#update"
      end

      scope :dashboard do
        get "dashboard/statistic_summary", to: "dashboard/statistic_summary#get"
      end

      scope :my_channel_view do
        get "my_channel_view/my_published_videos", to: "my_channel_view/my_published_videos#get"
      end


    end
  end

end