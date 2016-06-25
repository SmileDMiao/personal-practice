Rails.application.routes.draw do

  root 'home#index'

  get 'charts/chartjs', to: 'home#chartjs'
  get 'widgets', to: 'home#widgets'
  get 'form/general', to: 'home#general'
  get 'form/advanced_form', to: 'home#advanced_form'
  get 'form/editor', to:'home#editor'
  get 'ui/slider', to: 'home#slider'
  get 'ui/time_line', to: 'home#time_line'
  get 'ui/icons', to: 'home#icons'
  get 'ui/buttons', to: 'home#buttons'
  get 'ui/modals', to: 'home#modals'
  get 'ui/general_ui', to: 'home#general_ui'
  get 'example/invoice', to: 'home#invoice'
  get 'example/profile', to: 'home#profile'

end
