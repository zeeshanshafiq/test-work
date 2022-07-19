# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_19_060010) do
  create_table "disbursements", force: :cascade do |t|
    t.date "date", null: false
    t.integer "merchant_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id", "date"], name: "index_disbursements_on_merchant_id_and_date", unique: true
    t.index ["merchant_id"], name: "index_disbursements_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cif", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_merchants_on_email", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.integer "shopper_id", null: false
    t.integer "disbursement_id"
    t.float "amount", null: false
    t.datetime "completed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "index_orders_on_disbursement_id"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
    t.index ["shopper_id"], name: "index_orders_on_shopper_id"
  end

  create_table "shoppers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "nif", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_shoppers_on_email", unique: true
  end

  add_foreign_key "disbursements", "merchants"
  add_foreign_key "orders", "disbursements"
  add_foreign_key "orders", "merchants"
  add_foreign_key "orders", "shoppers"
end
