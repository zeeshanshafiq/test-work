require "test_helper"

class DisbursementTest < ActiveSupport::TestCase
  test "Disbursement generation" do
    merchant1 = Merchant.create(name: 'Merchant1', email: 'merchant1@domain.com', cif: '10001')
    merchant2 = Merchant.create(name: 'Merchant2', email: 'merchant2@domain.com', cif: '10001')
    # Shoppers
    shopper1 = Shopper.create(name: 'Shopper1', email: 'shopper1@domain.com', nif: '10001')
    shopper2 = Shopper.create(name: 'Shopper2', email: 'shopper2@domain.com', nif: '10001')
    shopper3 = Shopper.create(name: 'Shopper3', email: 'shopper3@domain.com', nif: '10001')

    # Merchant 1 orders
    order1 = Order.create(merchant: merchant1, shopper: shopper1, amount: 23.10, completed_at: Time.now)
    order2 = Order.create(merchant: merchant1, shopper: shopper2, amount: 53.10, completed_at: Time.now)
    order3 = Order.create(merchant: merchant1, shopper: shopper3, amount: 450.10, completed_at: Time.now)
    order4 = Order.create(merchant: merchant1, shopper: shopper3, amount: 450.10)

    order_1_total = 23.10 * 0.99
    order_2_total = 53.10 * 0.905
    order_3_total = 450.10 * 0.915
    d1_total = order_1_total + order_2_total + order_3_total
    Disbursement.process!
    assert_equal 1, Disbursement.count
    assert_equal 3, Disbursement.first.orders.count
    assert_equal d1_total, Disbursement.first.amount


    # Merchant 2 orders
    order5 = Order.create(merchant: merchant2, shopper: shopper1, amount: 49.99, completed_at: Time.now)
    order6 = Order.create(merchant: merchant2, shopper: shopper1, amount: 299.99, completed_at: Time.now)
    order7 = Order.create(merchant: merchant2, shopper: shopper1, amount: 380, completed_at: Time.now)
    order8 = Order.create(merchant: merchant2, shopper: shopper1, amount: 389, completed_at: Time.now, disbursement: Disbursement.first)

    Disbursement.process!

    order_5_total = 49.99 * 0.99
    order_6_total = 299.99 * 0.905
    order_7_total = 380 * 0.915
    d2_total = order_5_total + order_6_total + order_7_total
    assert_equal 2, Disbursement.count
    assert_equal d2_total, Disbursement.last.amount
  end
end
