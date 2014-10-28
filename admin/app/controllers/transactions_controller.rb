require_dependency '../bitcoupon/api/backend_request'
require_dependency '../bitcoupon/api/bitcoin_call'

# TransactionsController
class TransactionsController < ApplicationController
  def index
    set_coupons
  end

  def generate_create
    private_key = create_private_key
    payload     = params[:payload]

    return if refuse_payload_with_newlines payload

    output = bitcoin.new.generate_create_transaction(private_key, payload)

    if output.blank?
      render(text: 'Something went wrong')
    else
      @id = verify_transaction output
      redirect_to(root_path, notice: "Transaction #{@id} created")
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

  def set_coupons
    output = bitcoin.new.get_coupons(create_address, output_history)
    @coupons = JSON.parse(output)['coupons']

    output = bitcoin.new.get_coupons(return_address, output_history)
    @coupons_returned = JSON.parse(output)['coupons']

    output = bitcoin.new.get_coupon_owners(create_address, output_history)
    @coupons_circulating = JSON.parse(output)['couponOwners']

    reject_if_current_user
  end

  def reject_if_current_user
    if current_user.nil?
      return
    else
      @coupons_circulating = @coupons_circulating.reject do |coupon|
        coupon['ownerAddress'].eql?(current_user.create_address.chomp) ||
        coupon['ownerAddress'].eql?(current_user.return_address.chomp)
      end
    end
  end

  def refuse_payload_with_newlines(payload)
    alert_msg = 'Do not use newlines in payload'
    redirect_to(root_path, alert: alert_msg) if payload.match('\n')
    payload.match('\n')
  end

  def transaction_history
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    @transactions = JSON.parse(result.body)
  end

  def output_history
    request = backend_request.new :get, '/output_history'
    result = request.start

    JSON.parse(result.body)
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
    private_key = create_private_key

    # Public key: 138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6
    creator_address = params['public_key']
    payload = params['payload']

    # Receiver address: 1Kau4L6BM1h6QzLYubq1qWrQSjWdZFQgMb
    receiver_address = params['receiver_address']
    bitcoin.new.generate_send_transaction(private_key, creator_address, payload,
                                          receiver_address, output_history)
  end

  def create_address
    if current_user
      current_user.create_address.chomp
    else
      '138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6'
    end
  end

  def return_address
    if current_user
      current_user.return_address.chomp
    else
      '138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6'
    end
  end

  def create_private_key
    if current_user
      current_user.create_private_key.chomp
    else
      '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    end
  end
end
