Rails.application.routes.draw do
  namespace :backend do
    post 'verify_transaction', to: 'transactions#verify'
    get 'transaction_history', to: 'transactions#history'
    post 'output_history', to: 'transactions#output_history'
    get 'creator_addresses', to: 'transactions#creator_addresses'

    post 'address', to: 'addresses#address'
    post 'word', to: 'addresses#word'

    root to: 'transactions#empty'
  end

  root 'backend/transactions#empty'
end
