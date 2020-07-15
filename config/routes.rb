# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get '/language/:locale', to: 'users#language', as: :change_locale
  get 'register', to: 'users#register'
  get 'login', to: 'users#login'
  post 'sign_up', to: 'users#sign_up'
  delete 'logout', to: 'users#logout'

  post '/graphql', to: 'graphql#execute'

  # 搜索和通知
  get '/search' => 'search#index', as: 'search'
  get 'notifications/index' => 'notifications#index'
  delete 'notifications/clean' => 'notifications#clean'

  resources :users do
    member do
      patch :change_password
      get :articles
      get :comments
      get :favorites
      get :followers
      get :following
      post :follow
      post :unfollow
    end
  end

  get 'articles/node:id' => 'articles#node', as: 'node_articles'
  resources :articles do
    member do
      post :like
      delete :destroy_like
      post :favorite
      delete :destroy_favorite
    end
    collection do
      get :no_comment
      get :popular
    end
    resources :comments do
      post :like
      delete :destroy_like
    end
  end

  resources :chats

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  # 管理员后台
  namespace :admin do
    # sidekiq后台
    require 'sidekiq/web'
    require 'sidekiq-status/web'
    require 'sidekiq/grouping/web'
    require 'sidekiq-scheduler/web'
    mount Sidekiq::Web => '/sidekiq'

    root to: 'home#index', as: 'root'
    resources :sections
    resources :nodes
    get 'foods/new_simple', to: 'foods#new_simple'
    resources :foods
    get 'practices/bootstrap_table' => 'practices#bootstrap_table'
    get 'practices/get_data' => 'practices#get_data'
    resources :articles
  end

  mount ActionCable.server => '/cable'
end
