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

ActiveRecord::Schema[7.2].define(version: 2021_11_04_174731) do
  create_table "coverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "coverages_product_quotes", force: :cascade do |t|
    t.integer "coverage_id"
    t.integer "product_quote_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["coverage_id"], name: "index_coverages_product_quotes_on_coverage_id"
    t.index ["product_quote_id"], name: "index_coverages_product_quotes_on_product_quote_id"
  end

  create_table "product_quotes", force: :cascade do |t|
    t.integer "quote_id"
    t.string "provider_name"
    t.string "product_name"
    t.decimal "premium"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["quote_id"], name: "index_product_quotes_on_quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.date "departure_date"
    t.date "return_date"
    t.string "destination_country"
    t.integer "trip_cost"
    t.integer "travelers_count"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end
end
