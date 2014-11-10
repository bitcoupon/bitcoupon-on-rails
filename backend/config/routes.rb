Rails.application.routes.draw do
  namespace :backend do
    post 'verify_transaction', to: 'transactions#verify'
    post 'output_history', to: 'transactions#output_history'

    post 'address', to: 'addresses#address'
    post 'word', to: 'addresses#word'

    root to: 'transactions#empty'
  end

  root 'backend/transactions#empty'
end
