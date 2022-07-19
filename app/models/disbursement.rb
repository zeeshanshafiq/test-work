class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders

  def self.process!
    Merchant.eager_load(:orders).where.not(orders: { completed_at: nil }).find_in_batches(batch_size: 50) do |merchant_group|
      merchant_group.each do |merchant|
        begin
          merchant.do_disbursement
        rescue => e
          puts """""""""""Merchant #{merchant.id} **************"
          puts e.message
          puts e.backtrace
          puts """"""""""" End  **************"
        end
      end
    end
  end

end