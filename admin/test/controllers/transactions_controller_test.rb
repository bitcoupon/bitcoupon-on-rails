require 'test_helper'

# TransactionsControllerTest
# Tests the controller for the transactions
class TransactionsControllerTest < ActionController::TestCase
  test 'get coupons' do
    session[:user_id] = users(:one).id
    get :index
    assert_response :success
  end
end
