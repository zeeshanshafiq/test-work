class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.date :date, null: false
      t.references :merchant, null: false, foreign_key: true
      t.float :amount, null: false

      t.timestamps
    end
    add_index :disbursements, %i[merchant_id date], unique: true
  end
end
