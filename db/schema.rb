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

ActiveRecord::Schema[7.0].define(version: 2022_06_16_063751) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "vendor", null: false
    t.string "alias"
    t.string "code"
    t.boolean "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "vendor_id", null: false
    t.bigint "codetype_id", null: false
    t.index ["codetype_id"], name: "index_cards_on_codetype_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
    t.index ["vendor_id"], name: "index_cards_on_vendor_id"
  end

  create_table "codetypes", force: :cascade do |t|
    t.string "name", null: false
    t.string "alias", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name", null: false
    t.string "codetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alias", null: false
    t.bigint "codetype_id", null: false
    t.index ["codetype_id"], name: "index_vendors_on_codetype_id"
  end

  add_foreign_key "cards", "codetypes"
  add_foreign_key "cards", "users"
  add_foreign_key "cards", "vendors"
  add_foreign_key "vendors", "codetypes"
end
