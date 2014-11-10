# TransactionsHelper
module TransactionsHelper
  def translate_address(address)
    return nil if address.blank? || address.eql?('nil')

    address_cache = Address.where(address: address).first
    return address_cache.word unless address_cache.nil?

    request = backend_request.new :post, '/address'
    request.content_type = 'application/json'
    request.body = { address: address.chomp }.to_json
    result = request.start

    word = JSON.parse(result.body)['word'].chomp if result
    Address.create(address: address, word: word.chomp) if word
    word
  end

  private

  def backend_request
    Bitcoupon::Api::BackendRequest
  end
end
