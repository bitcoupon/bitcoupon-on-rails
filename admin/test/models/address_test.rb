require 'test_helper'

# AddressTest
class AddressTest < ActiveSupport::TestCase
  test 'address should have word' do
    address = address(:one)
    assert address.word.eql?('kake')
    assert address.address.eql?('138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6')
  end
end
