require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test 'Email field validations' do
    merchant = Merchant.new(name: 'Merchant', cif: '10001')
    refute merchant.valid?
    assert merchant.errors
    assert merchant.errors.messages[:email].include?("can't be blank")
    merchant.email = 'merchantdomain.com'
    refute merchant.valid?
    refute merchant.errors.messages[:email].include?("can't be blank")
    assert merchant.errors.messages[:email].include?("is invalid")
    merchant.email = 'merchant@domain.com'
    assert merchant.valid?
    merchant.save

    merchant1 = Merchant.new(email: 'merchant@domain.com')
    refute merchant1.valid?
  end

  test 'CIF field is required' do
    merchant = Merchant.new(name: 'Merchant', email: 'merchant@domain.com')
    refute merchant.valid?
    assert merchant.errors.messages[:cif].present?
    merchant.cif = '10001'
    assert merchant.valid?
  end

  test 'Name field is required' do
    merchant = Merchant.new(cif: '10001', email: 'merchant@domain.com')
    refute merchant.valid?
    assert merchant.errors.messages[:name].present?
    merchant.name = 'Merchant'
    assert merchant.valid?
  end

end
