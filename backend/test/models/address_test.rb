require 'test_helper'

# AddressTest
class AddressTest < ActiveSupport::TestCase
  test 'address should have address method' do
    address = addresses(:one)
    assert address.address.length > 0
  end

  test 'address should be able to have and get word' do
    address = addresses(:one)
    word = words(:one)
    address.word = word
    assert address.word.word.eql?(word.word)
  end
end
