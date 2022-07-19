require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "Merchant is required" do
    shopper = Shopper.new(email: "shopper@domain.com")
    order = Order.new(shopper: shopper, amount: 23.00)
    refute order.valid?

    merchant = Merchant.new(email: "merchant@domain.com")
    order.merchant = merchant
    assert order.valid?
  end

  test "Shopper is required" do
    merchant = Merchant.new(email: "merchant@domain.com")
    order = Order.new(merchant: merchant, amount: 23.00)
    refute order.valid?

    shopper = Shopper.new(email: "shopper@domain.com")
    order.shopper = shopper
    assert order.valid?
  end

  test "Validate amount field" do
    merchant = Merchant.new(email: "merchant@domain.com")
    shopper = Shopper.new(email: "shopper@domain.com")
    order = Order.new(merchant: merchant, shopper: shopper)
    refute order.valid?

    order.amount = 23.00
    assert order.valid?
  end

end
