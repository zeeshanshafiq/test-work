class Merchant < ApplicationRecord
  include CsvImporter
  has_many :orders
  has_many :disbursements

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, :cif, presence: true

  def do_disbursement(date: Date.today)
    transaction do
      not_disbursed_orders = orders.not_disbursed.map(&:id)
      return if  not_disbursed_orders.empty?
      disbursement_amount = orders.select("sum( case
                          when amount < 50 then amount * 0.99
                            when amount < 300 then amount * 0.905
                          else amount * 0.915
                        end
                      ) as disbursement_amount").where(id: not_disbursed_orders).first.try(:disbursement_amount)
      disbursement = self.disbursements.create!(date: date, amount: disbursement_amount)
      Order.where(id: not_disbursed_orders).update_all(disbursement_id: disbursement.id)
    end
  end

end
