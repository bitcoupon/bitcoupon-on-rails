Rails.application.routes.draw do
  namespace :backend do
    post 'coupons', to: 'coupons#create'
    get 'coupons', to: 'coupons#index'
    get 'coupon/:id', to: 'coupons#show'
    delete 'coupon/:id', to: 'coupons#destroy'

    post 'verify_transaction', to: 'transactions#verify'
    get 'transaction_history', to: 'transactions#history'
    get 'creator_addresses', to: 'transactions#creator_addresses'

    get 'statistics/total', to: 'statistics#total'
  end

  root 'backend/transactions#history'
end
