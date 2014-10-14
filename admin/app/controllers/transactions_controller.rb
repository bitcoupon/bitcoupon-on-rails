require_dependency '../bitcoupon/api/backend_request'
require_dependency '../bitcoupon/api/bitcoin_call'

# TransactionsController
class TransactionsController < ApplicationController
  def index
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    transaction_history = JSON.parse(result.body).to_s

    output = bitcoin.new.creator_addresses(private_key, transaction_history)

    @transactions = output.split("\n")
  end

  def generate_creation
    private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    output = bitcoin.new.generate_creation_transaction(private_key)

    if output.blank?
      render(text: 'Something went wrong')
    else
      @id = verify_transaction output
      parsed_output = JSON.parse(output)

      @transaction = Transaction.from_json(parsed_output)
    end
  end

  def generate_send
    output = send_transaction

    if output.blank?
      render text: 'Something went wrong'
    else
      id = verify_transaction output
      redirect_to(root_path,
                  notice: "Transaction #{id} has been "\
                           "sent to #{params['receiver_address']}")
    end
  end

  private

  def transaction_history
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    @transactions = JSON.parse(result.body)
  end

  def verify_transaction(output)
    request = backend_request.new :post, '/verify_transaction'
    request.content_type = 'application/json'
    request.body = { transaction: output }.to_json
    result = request.start

    id = result.header['id'].to_i
    id
  end

  def send_transaction
    private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'

    # Public key: 138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6
    creator_address = params['public_key']
    history = transaction_history.to_s

    # Receiver address: 1Kau4L6BM1h6QzLYubq1qWrQSjWdZFQgMb
    receiver_address = params['receiver_address']

    bitcoin.new.generate_send_transaction(private_key, creator_address,
                                          history, receiver_address)
  end
end
