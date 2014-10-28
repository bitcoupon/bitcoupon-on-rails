require 'test_helper'
require 'minitest/mock'

module Admin
  # CouponsControllerTest
  class CouponsControllerTest < ActionController::TestCase
    setup do
      @valid_coupons = "{\"pubkey\":\"sdgkj32pidklj23lkjd\",\"coupons\":\
[{\"id\":1,\"title\":\"Beer Coupon\",\"created_at\":\"2014-10-28T10:34:41\
.517Z\",\"updated_at\":\"2014-10-28T10:34:41.517Z\",\"description\":\"\
Get one free beer\",\"user_id\":null}]}"
    end

    test 'should get index' do
      uri = URI.parse('http://localhost:3002/backend/coupons')
      request = Net::HTTP::Get.new(uri.path)
      request.add_field 'token', 'sdgkj32pidklj23lkjd'

      @http = Minitest::Mock.new
      @result = Minitest::Mock.new
      @result.expect(:header, 'token' => 'sdgkj32pidklj23lkjd')
      @result.expect(:body, @valid_coupons)
      @http.expect :request, @result, [Net::HTTP::Get]
      @http.expect :request, @result, [Net::HTTP::Get]

      Net::HTTP.stub :start, @result, @http do
        get :index
        assert_response :success
        assert_not_nil assigns(:coupons)
      end
    end
  end
end
