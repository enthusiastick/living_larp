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

ActiveRecord::Schema.define(version: 20140122212206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: true do |t|
    t.string   "name",             null: false
    t.integer  "available_points"
    t.integer  "user_id",          null: false
    t.integer  "game_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
  end

  create_table "game_trait_dependencies", force: true do |t|
    t.integer  "parent_trait_id"
    t.integer  "child_trait_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_trait_dependencies", ["parent_trait_id", "child_trait_id"], name: "prerequisite_game_trait_index", unique: true, using: :btree

  create_table "game_traits", force: true do |t|
    t.string   "name",          null: false
    t.integer  "max_purchases"
    t.boolean  "bgs"
    t.integer  "point_cost",    null: false
    t.integer  "game_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name",            null: false
    t.integer  "starting_points", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         null: false
    t.text     "description"
  end

  create_table "players", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "game_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",     default: 0
  end

  add_index "players", ["game_id", "user_id"], name: "index_players_on_game_id_and_user_id", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "traits", force: true do |t|
    t.integer  "purchases",     null: false
    t.integer  "points_spent",  null: false
    t.integer  "game_trait_id", null: false
    t.integer  "character_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traits", ["game_trait_id", "character_id"], name: "character_traits_index", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "frood_on"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
