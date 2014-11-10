require 'test_helper'

module Backend
  # TransactionsControllerTest
  class TransactionsControllerTest < ActionController::TestCase
    test 'should get empty with empty response body' do
      get :empty
      assert_response :success
      assert response.body.length.eql?(0)
    end

    test 'should return 401 when posting without token' do
      [:verify, :output_history].each do |endpoint|
        post endpoint
        result = JSON.parse(response.body)
        error = result['error']
        assert error.eql?('No token given')
        assert_response 401
      end
    end

    test 'should return when posting with invalid token' do
      [:verify, :output_history].each do |endpoint|
        request.headers['token'] = 'something'
        post endpoint
        result = JSON.parse(response.body)
        error = result['error']
        assert error.eql?('Wrong token given')
        assert_response 401
      end
    end

    test 'should get error with invalid history request' do
      request.headers['token'] = Rails.application.secrets.api_secret
      body = { output_history_request: invalid_history_request }
      post :output_history, body, type: :json
      result = JSON.parse(response.body)
      error = result['error']
      assert error.eql?('INVALID OUTPUT HISTORY REQUEST')
      assert_response 401
    end

    test 'post output_history should get empty outputList' do
      request.headers['token'] = Rails.application.secrets.api_secret
      body = { output_history_request: valid_history_request }
      post :output_history, body, type: :json
      assert_response :success
      assert JSON.parse(response.body)['outputList'].empty?
    end

    private

    def invalid_history_request
      valid = JSON.parse(valid_history_request)
      valid['address'] = valid['address'].reverse
      invalid = valid.to_json
      invalid
    end

    def valid_history_request
      {
        address: '1M9ekP5oXHqh5HKoN7JLQNFw2xWWHnsC1Y',
        signature: "EsykzCmunhWeEzXiJDoRJH51uHAMvtYPyXZPN1uKN2Vt3KoRmEqatG7CHcd\
LDr2k8PeUM2AR2rEfBCA2k4P8YgbYxqJSZiUTSZo8b 3kQ15Dd1ro8iRM6ygpZFiwiGVK6rhv3YeZPK\
EH9oBJ5isbvdHVkFPi8ycGCM7QTZnXSukrQH5kMVKrTPVr76e5XKdndLQr"
      }.to_json.chomp
    end
  end
end
