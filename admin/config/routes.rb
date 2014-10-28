Rails.application.routes.draw do
  resources :users
  namespace :admin do
    get 'coupons', to: 'coupons#index'
    get 'coupon/:id', to: 'coupons#show', as: 'coupon'
    get 'new_coupon', to: 'coupons#new', as: 'new_coupon'
    post 'coupons', to: 'coupons#create'
    delete 'coupon/:id', to: 'coupons#destroy'
  end

  post 'signin', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  post 'generate_create_transaction', to: 'transactions#generate_create'
  post 'generate_send_transaction', to: 'transactions#generate_send'

  root 'transactions#index'
end
