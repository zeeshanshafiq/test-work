class Shopper < ApplicationRecord
  include CsvImporter
  has_many :orders
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, :nif, presence: true
end
