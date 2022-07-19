class Order < ApplicationRecord
  include CsvImporter
  belongs_to :merchant
  belongs_to :shopper
  belongs_to :disbursement, optional: true

  scope :completed, -> {where.not(completed_at: nil)}
  scope :not_disbursed, -> {completed.where(disbursement_id: nil)}

  validates :amount, presence: true, numericality: true
end
