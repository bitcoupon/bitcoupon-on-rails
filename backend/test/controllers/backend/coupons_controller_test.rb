require 'test_helper'

module Backend
  # CouponsControllerTest
  class CouponsControllerTest < ActionController::TestCase
    setup do
      @coupon = coupons(:one)
      request.headers['token'] = 'token'
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert response.content_type.eql?('application/json')
    end
  end
end
