require 'test_helper'

# API Test
# Tests that the admin client can get a valid
# response from the backend.
class ApiTest < ActionDispatch::IntegrationTest
  setup do
    @api = 'http://localhost:3002/backend'
  end

  test 'should get correct response from api' do
    uri = URI.parse(@api)
    req = Net::HTTP::Get.new(uri)

    result = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    assert result.code.to_i.eql? 200
    assert result.body.eql? ''
  end
end
