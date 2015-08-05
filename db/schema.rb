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

ActiveRecord::Schema.define(version: 20150805111018) do

  create_table "rewards", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "image_url",   limit: 255
    t.integer  "amount_cost", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "child_id",    limit: 4
    t.string   "status",      limit: 255
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "to_do",         limit: 255
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "amount_earned", limit: 4
    t.string   "status",        limit: 255
    t.integer  "child_id",      limit: 4
  end

  create_table "user_interests", force: :cascade do |t|
    t.decimal  "interest_rate",                       precision: 10, scale: 2
    t.decimal  "money_invested",                      precision: 30, scale: 2
    t.decimal  "last_investment_balance",             precision: 30, scale: 2
    t.decimal  "final_balance",                       precision: 30, scale: 2
    t.string   "withdrawl_status",        limit: 255
    t.integer  "child_id",                limit: 4
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "duration",                limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                          default: "", null: false
    t.string   "encrypted_password",     limit: 255,                          default: "", null: false
    t.integer  "role_id",                limit: 4
    t.integer  "parent_id",              limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.decimal  "total_balance",                      precision: 10, scale: 2
    t.decimal  "interest_rate",                      precision: 10, scale: 2
    t.string   "first_name",             limit: 255
    t.string   "image_url",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
