class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :cif, null: false

      t.timestamps
    end
  end
end
