require 'test_helper'

# API Test
class ApiTest < ActionDispatch::IntegrationTest
  setup do
    @api = 'http://localhost:3002/backend/creator_addresses'
    @pubkey = 'sdflkj3209ikldjf23kljsd'
  end

  test 'should get correct response from api' do
    uri = URI.parse(@api)
    req = Net::HTTP::Get.new(uri)

    req.add_field 'token', @pubkey

    result = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    assert result.code.to_i.eql? 200
    refute result.body.nil?
  end
end
