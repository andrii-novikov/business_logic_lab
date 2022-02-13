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

ActiveRecord::Schema[7.0].define(version: 2022_02_13_120758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.date "from"
    t.date "till"
    t.bigint "zone_1_from"
    t.bigint "zone_2_from"
    t.bigint "zone_1_till"
    t.bigint "zone_2_till"
    t.bigint "zone_1"
    t.bigint "zone_2"
    t.bigint "total"
    t.bigint "tariff"
    t.bigint "zone_1_amount"
    t.bigint "zone_2_amount"
    t.bigint "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emeter_readings", force: :cascade do |t|
    t.date "date"
    t.bigint "zone_1"
    t.bigint "zone_2"
    t.integer "source_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
