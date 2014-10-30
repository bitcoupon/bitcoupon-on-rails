require_dependency '../bitcoupon/api/backend_request'

# TransactionsHelper
module TransactionsHelper
  def translate_address(address)
    return nil if address.blank? || address.eql?('nil')

    request = backend_request.new :post, '/address'
    request.content_type = 'application/json'
    request.body = { address: address }.to_json
    result = request.start

    word = JSON.parse(result.body)['word'].chomp
    word
  end

  private

  def backend_request
    Bitcoupon::Api::BackendRequest
  end
end
