Rails.application.routes.draw do

  root 'home#index'

  get '/language/:locale', to: 'users#language', as: :change_locale
  get 'register', to: 'users#register'
  get 'login', to: 'users#login'
  post 'sign_up', to: 'users#sign_up'
  delete 'logout', to: 'users#logout'
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

  # 搜索和通知
  get '/search' => 'search#index', as: 'search'
  get 'notifications/index' => 'notifications#index'
  delete 'notifications/clean' => 'notifications#clean'

  # 管理员后台
  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :sections
    resources :nodes
    get 'foods/new_simple', to: 'foods#new_simple'
    resources :foods
    get 'practices/soulmate' => 'practices#soulmate'
    get 'practices/bootstrap_table' => 'practices#bootstrap_table'
    get 'practices/get_data' => 'practices#get_data'
  end

  # sidekiq后台
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # redis自动输入完成搜索地址
  require 'soulmate/server'
  mount Soulmate::Server, :at => '/sm'

  resource :wechat, only: [:show, :create]

end
