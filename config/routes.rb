Rails.application.routes.draw do

  root 'home#index'

  get 'foods/new_simple', to: 'foods#new_simple'
  resources :foods

  get '/language/:locale', to: 'users#language', as: :change_locale
  get 'register', to: 'users#register'
  get 'login', to: 'users#login'
  post 'sign_up', to: 'users#sign_up'
  delete 'logout', to: 'users#logout'
  resources :users

  resources :articles

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :users
  end

end
