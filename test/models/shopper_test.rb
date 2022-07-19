require "test_helper"

class ShopperTest < ActiveSupport::TestCase
  test 'Email field is required' do
    shopper = Shopper.new(name: 'Shopper', nif: '1001')
    refute shopper.valid?
    assert shopper.errors
    assert shopper.errors.messages[:email].include?("can't be blank")
    shopper.email = 'shopperdomain.com'
    refute shopper.valid?
    refute shopper.errors.messages[:email].include?("can't be blank")
    assert shopper.errors.messages[:email].include?("is invalid")
    shopper.email = 'shopper@domain.com'
    assert shopper.valid?
    shopper.save

    shopper1 = Shopper.new(email: 'shopper@domain.com', name: 'shopper1', nif: '1001')
    refute shopper1.valid?
  end

  test 'NIF field is required' do
    shopper = Shopper.new(name: 'Merchant', email: 'shopper@domain.com')
    refute shopper.valid?
    assert shopper.errors.messages[:nif].present?
    shopper.nif = '10001'
    assert shopper.valid?
  end

  test 'Name field is required' do
    shopper = Shopper.new(nif: '10001', email: 'shopper@domain.com')
    refute shopper.valid?
    assert shopper.errors.messages[:name].present?
    shopper.name = 'Merchant'
    assert shopper.valid?
  end
end
