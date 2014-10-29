module Backend
  # TransactionsController
  class TransactionsController < ApplicationController
    skip_before_filter(:verify_authenticity_token,
                       only: [:verify, :output_history])

    before_action(:check_headers,
                  only: [:history, :output_history,
                         :verify, :creator_addresses])

    def verify
      transaction = transaction_params

      result = bitcoin.new.verify_transaction(transaction, Output.all_history)

      transaction = Transaction.from_json(transaction)

      if result && transaction.save
        response.headers['id'] = transaction.id.to_s
        render json: transaction
      else
        render json: '{"error":"TRANSACTION NOT SAVED"}', status: 401
      end
    end

    def history
      render json: Transaction.history
    end

    def output_history
      request = params['output_history_request']
      address = JSON.parse(request)['address']

      result = bitcoin.new.verify_output_history_request(request)

      if result
        render json: Output.history(address)
      else
        render json: '{"error":"INVALID OUTPUT HISTORY REQUEST"}', status: 401
      end
    end

    # TODO: Marked for deletion, or used by app?
    def creator_addresses
      private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
      output = bitcoin.new.creator_addresses private_key, Transaction.history

      render json: output
    end

    private

    def transaction_params
      transaction = params[:transaction]

      unless transaction.class.eql?(String)
        # TODO: The Android app should never send nils in JSON
        transaction['creations'] = [] if transaction['creations'].nil?
        transaction = transaction.to_json.to_s
      end

      transaction
    end

    def check_headers
      if token.blank?
        render json: '{"error":"No token given"}'
        return
      end
      response.headers['token'] = token
    end

    def token
      token = request.headers['token']
      token = params[:token] if token.nil? && params[:token]
      token
    end
  end
end
