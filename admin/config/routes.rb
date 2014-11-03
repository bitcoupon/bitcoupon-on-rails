Rails.application.routes.draw do
  resources :users

  post 'signin', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  post 'generate_create_transaction', to: 'transactions#generate_create'
  post 'generate_send_transaction', to: 'transactions#generate_send'
  post 'generate_delete_transaction', to: 'transactions#generate_delete'
  get 'coupons', to: 'transactions#index'

  get 'welcome', to: 'users#welcome'

  root 'users#welcome'
end
