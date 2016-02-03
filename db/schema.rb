# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160203151308) do

  create_table "calculations", force: :cascade do |t|
    t.string   "base_currency"
    t.string   "target_currency"
    t.integer  "amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "nb_weeks"
    t.integer  "user_id"
  end

  add_index "calculations", ["user_id", "updated_at"], name: "index_calculations_on_user_id_and_updated_at"
  add_index "calculations", ["user_id"], name: "index_calculations_on_user_id"

  create_table "daily_currency_rates", force: :cascade do |t|
    t.date     "day"
    t.string   "currency"
    t.text     "rates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "daily_currency_rates", ["day", "currency"], name: "index_daily_currency_rates_on_day_and_currency"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
