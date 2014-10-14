require 'test_helper'

# API Test
class ApiTest < ActionDispatch::IntegrationTest
  setup do
    @api = 'http://localhost:3002/backend/coupons'
    @pubkey = 'sdflkj3209ikldjf23kljsd'
  end

  test 'should get correct response from api' do
    uri = URI.parse(@api)
    req = Net::HTTP::Get.new(uri)

    req.add_field 'token', @pubkey

    result = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    body = JSON.parse(result.body)
    result = body['pubkey']

    assert result.eql?(@pubkey)
  end
end
