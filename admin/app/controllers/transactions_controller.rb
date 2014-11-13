# TransactionsController
# rubocop:disable Metrics/ClassLength
class TransactionsController < ApplicationController
  before_action :require_signin!

  include ActionView::Helpers::TextHelper

  def index
    @return_address = return_address
    @create_address = create_address
    set_coupons
  end

  # rubocop:disable Metrics/MethodLength
  def generate_create
    output = ''
    create_amount.times do
      output = bitcoin.generate_create_transaction(create_private_key,
                                                   create_payload)
      _id = verify_transaction output unless output.blank?
    end

    if output.blank?
      render(text: 'Something went wrong')
    else
      flash[:notice] = "#{pluralize(amount, 'coupon')} with \
title \"#{JSON.parse(payload)['title']}\" created"
      render js: 'window.location.reload();'
    end
  end

  def generate_send
    output = send_transaction

    if translate_word(params['receiver_address'].downcase).blank?
      flash[:alert] = "Address not found \"#{params['receiver_address']}\"."
      render js: 'window.location.reload();'
    elsif output.blank?
      render text: 'Something went wrong'
    else
      _id = verify_transaction output
      flash[:notice] = "Coupon #{JSON.parse(params[:payload])['title']}\
 has been sent to #{params['receiver_address']}"
      render js: 'window.location.reload();'
    end
  end
  # rubocop:enable Metrics/MethodLength

  def generate_delete
    output = delete_transaction

    if output.blank?
      render text: 'Something went wrong'
    else
      _id = verify_transaction output
      flash[:notice] = "Coupon #{JSON.parse(params[:payload])['title']}\
has been deleted"
      render js: 'window.location.reload();'
    end
  end

  private

  def set_coupons
    output = bitcoin.get_coupons(create_address,
                                 output_history(create_private_key))
    @coupons = JSON.parse(output)['coupons']

    output = bitcoin.get_coupons(return_address,
                                 output_history(return_private_key))
    @coupons_returned = JSON.parse(output)['coupons']

    output = bitcoin.get_coupon_owners(create_address,
                                       output_history(create_private_key))
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

  def create_amount
    amount      = params[:amount].to_i
    amount      = 1 if amount.nil? || amount < 1
    amount
  end

  def create_payload
    {
      title: params[:title],
      description: params[:description],
      returnWord: params[:return_word],
      timestamp: (Time.now.to_i * 1000).to_s
    }.to_json
  end

  def transaction_history
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    @transactions = JSON.parse(result.body)
  end

  def output_history(private_key)
    request = backend_request.new :post, '/output_history'
    request.content_type = 'application/json'
    request.body = {
      output_history_request: output_history_request(private_key)
    }.to_json
    result = request.start

    JSON.parse(result.body)
  end

  def output_history_request(private_key)
    if current_user
      current_user.output_history_request(private_key)
    else
      bitcoin.generate_output_history_request(private_key)
    end
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
    # Public key: 138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6
    creator_address = params['public_key']
    payload         = params['payload']

    # Receiver address: 1Kau4L6BM1h6QzLYubq1qWrQSjWdZFQgMb
    receiver_address = translate_word(params['receiver_address'].downcase)

    if receiver_address.nil?
      nil
    else
      bitcoin.generate_send_transaction(
                    create_private_key, creator_address, payload,
                    receiver_address, output_history(create_private_key))
    end
  end

  def delete_transaction
    if params['priv_key'].eql?('create')
      private_key = create_private_key
    else
      private_key = return_private_key
    end

    creator_address = params['public_key']
    payload = params['payload']

    bitcoin.generate_delete_transaction(
                  private_key, creator_address, payload,
                  output_history(private_key))
  end
end
# rubocop:enable Metrics/ClassLength
