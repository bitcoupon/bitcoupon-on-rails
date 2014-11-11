module Backend
  # TransactionsController
  # This controller receives requests from the clients, and
  #   delegates the work to the Bitcoupon Java library.
  # It also uses Transaction and Output models to interact with
  #   the database.
  # All the methods (except empty) render JSON.
  class TransactionsController < ApplicationController
    before_action :check_headers, only: [:verify, :output_history]

    # GET /backend/empty
    # Used by the mobile client to check for a 200 response.
    def empty
      render text: ''
    end

    # POST /backend/verify_transaction
    # Receives a transaction, and verifies it using the Bitcoupon Java library.
    # If the transaction is valid it is saved to the database.
    def verify
      transaction = transaction_params

      result = bitcoin.new.verify_transaction(transaction, Output.all_history)

      if result && Transaction.from_json(transaction).save
        response.headers['id'] = transaction.id.to_s
        render json: transaction
      else
        render json: '{"error":"TRANSACTION NOT SAVED"}', status: 401
      end
    end

    # POST /backend/output_history
    # Returns the output history for a given address.
    # Must be given a valid, signed history request, so that
    # only the owner of the address can request his history.
    def output_history
      history_request = set_history_request
      address = JSON.parse(history_request)['address']

      result = bitcoin.new.verify_output_history_request(history_request)

      if result
        render json: Output.history(address)
      else
        render json: '{"error":"INVALID OUTPUT HISTORY REQUEST"}', status: 401
      end
    end

    private

    # The mobile client uses null in JSON, instead of empty array.
    # We therefore have to translate the params to this form.
    def transaction_params
      transaction = params[:transaction]

      unless transaction.class.eql?(String)
        transaction['creations'] = [] if transaction['creations'].nil?
        transaction = transaction.to_json.to_s
      end

      transaction
    end

    # The mobile and admin clients access the output_history endpoint
    # differently. This discrepancy is handled here.
    def set_history_request
      if params['output_history_request']
        params['output_history_request']
      else
        JSON.parse(request.body.string)['output_history_request'].to_json
      end
    end
  end
end
