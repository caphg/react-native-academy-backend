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

ActiveRecord::Schema.define(version: 20180323161420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string  "name"
    t.string  "phone"
    t.integer "todo_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.text   "description"
    t.string "image_url"
  end

  create_table "todos_users", id: false, force: :cascade do |t|
    t.integer "todo_id", null: false
    t.integer "user_id", null: false
    t.index ["todo_id"], name: "index_todos_users_on_todo_id", using: :btree
    t.index ["user_id"], name: "index_todos_users_on_user_id", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "total_distance",                     null: false
    t.integer  "vehicle_id",                         null: false
    t.string   "starting_point_name"
    t.string   "ending_point_name"
    t.date     "date",                               null: false
    t.boolean  "is_official",         default: true
    t.integer  "starting_distance"
    t.datetime "created_at"
    t.text     "description"
    t.index ["vehicle_id", "date"], name: "index_trips_on_vehicle_id_and_date", using: :btree
    t.index ["vehicle_id", "is_official"], name: "index_trips_on_vehicle_id_and_is_official", using: :btree
    t.index ["vehicle_id", "starting_distance"], name: "index_trips_on_vehicle_id_and_starting_distance", using: :btree
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.string  "license_plate",               null: false
    t.string  "car_brand",                   null: false
    t.integer "year"
    t.integer "user_id",                     null: false
    t.integer "start_at",        default: 0
    t.integer "amount_traveled", default: 0, null: false
    t.index ["user_id", "license_plate"], name: "index_vehicles_on_user_id_and_license_plate", unique: true, using: :btree
  end

end
