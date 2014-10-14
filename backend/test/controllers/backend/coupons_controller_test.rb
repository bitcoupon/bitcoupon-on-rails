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
      assert_not_nil assigns(:coupons)
    end
  end
end
