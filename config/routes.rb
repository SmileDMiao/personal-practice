Rails.application.routes.draw do

  root 'home#index'

  get 'foods/new_simple', to: 'foods#new_simple'
  resources :foods

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
    resources :comments do
      post :like
      delete :destroy_like
    end
  end

  get 'notifications/index' => 'notifications#index'
  delete 'notifications/clean' => 'notifications#clean'

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :users
    resources :sections
    resources :nodes
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
