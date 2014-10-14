require 'test_helper'

# CouponTest
class CouponTest < ActiveSupport::TestCase
  test 'coupon should have title' do
    coupon = coupons(:one)
    assert coupon.title.length > 0
  end
end
