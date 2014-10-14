require 'test_helper'

module Backend
  # TransactionsControllerTest
  class TransactionsControllerTest < ActionController::TestCase
    test 'should get history' do
      get :history
      assert_response :success
    end

    test 'should get creator addresses' do
      get :creator_addresses
      assert_response :success
    end
  end
end
