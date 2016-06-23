Rails.application.routes.draw do

  root 'home/home_page#index'

  get 'charts', to: 'home/charts_plugin#chartjs'
  get 'charts/chartjs', to: 'home/charts_plugin#chartjs'
  get 'full_calendar', to: 'home/full_calendar#index'
  get 'datatables', to: 'home/datatables#index'
  get 'advanced_form', to: 'home/forms#advanced_form'

end
