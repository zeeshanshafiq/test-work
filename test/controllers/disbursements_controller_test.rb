require "test_helper"

class DisbursementControllerTest < ActionDispatch::IntegrationTest
  test "should get disbursements and filter by date and merchant" do
    get filter_disbursements_path(date: Date.today)
    assert_response :success
    last_response = JSON.parse response.body
    assert_equal 0, last_response.count
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


    # Merchant 2 orders
    order5 = Order.create(merchant: merchant2, shopper: shopper1, amount: 49.99, completed_at: Time.now)
    order6 = Order.create(merchant: merchant2, shopper: shopper1, amount: 299.99, completed_at: Time.now)
    order7 = Order.create(merchant: merchant2, shopper: shopper1, amount: 380, completed_at: Time.now)

    Disbursement.process!

    get filter_disbursements_path(date: Date.today)
    assert_response :success

    last_response = JSON.parse response.body
    assert_equal 2, last_response.count

    get filter_disbursements_path(date: Date.today, merchant_id: merchant1.id)
    assert_response :success

    last_response = JSON.parse response.body
    assert_equal 1, last_response.count
  end
end
