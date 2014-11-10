# TransactionsController
# rubocop:disable Metrics/ClassLength
class TransactionsController < ApplicationController
  before_filter :require_signin!

  include ActionView::Helpers::TextHelper

  def index
    @return_address = return_address
    @create_address = create_address
    set_coupons
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
  def generate_create
    private_key = create_private_key
    payload     = build_payload(params[:title],
                                params[:return_word],
                                params[:description])
    amount      = params[:amount].to_i
    amount      = 1 if amount.nil? || amount.eql?(0) || amount < 1

    return if refuse_payload_with_newlines payload

    output = ''
    amount.times do
      output = bitcoin.new.generate_create_transaction(private_key, payload)
      @id = verify_transaction output unless output.blank?
    end

    if output.blank?
      render(text: 'Something went wrong')
    else
      respond_to do |format|
        format.js do
          flash[:notice] = "#{pluralize(amount, 'coupon')} with \
title \"#{JSON.parse(payload)['title']}\" created"
        end
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def generate_send
    output = send_transaction

    if translate_word(params['receiver_address'].downcase).blank?
      respond_to do |format|
        format.js do
          flash[:alert] = "Address not found \"#{params['receiver_address']}\"."
        end
      end
    elsif output.blank?
      render text: 'Something went wrong'
    else
      @id = verify_transaction output
      respond_to do |format|
        format.js do
          flash[:notice] = "Coupon #{JSON.parse(params[:payload])['title']}\
 has been sent to #{params['receiver_address']}"
        end
      end
    end
  end

  def generate_delete
    output = delete_transaction

    if output.blank?
      render text: 'Something went wrong'
    else
      @id = verify_transaction output
      respond_to do |format|
        format.js do
          flash[:notice] = "Coupon #{JSON.parse(params[:payload])['title']}\
has been deleted"
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def set_coupons
    output = bitcoin.new
               .get_coupons(create_address, output_history(create_private_key))
    @coupons = JSON.parse(output)['coupons']

    output = bitcoin.new
               .get_coupons(return_address, output_history(return_private_key))
    @coupons_returned = JSON.parse(output)['coupons']

    output = bitcoin.new.get_coupon_owners(
              create_address, output_history(create_private_key))
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

  def build_payload(title, word, description)
    {
      title: title,
      description: description,
      returnWord: word,
      timestamp: (Time.now.to_i * 1000).to_s
    }.to_json
  end

  def refuse_payload_with_newlines(payload)
    alert_msg = 'Do not use newlines in title'
    redirect_to(coupons_path, alert: alert_msg) if payload.match('\n')
    payload.match('\n')
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
      bitcoin.new.generate_output_history_request(private_key)
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
      bitcoin.new.generate_send_transaction(
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

    bitcoin.new.generate_delete_transaction(
                  private_key, creator_address, payload,
                  output_history(private_key))
  end
end
# rubocop:enable Metrics/ClassLength
