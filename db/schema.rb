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

ActiveRecord::Schema.define(version: 2021_06_27_183013) do

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "wikidata_id"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "distances", force: :cascade do |t|
    t.float "distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "from_city_id"
    t.integer "to_city_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.float "volume"
    t.float "weight"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "distance_id"
  end

  add_foreign_key "distances", "cities", column: "from_city_id"
  add_foreign_key "distances", "cities", column: "to_city_id"
  add_foreign_key "parcels", "distances"
end
