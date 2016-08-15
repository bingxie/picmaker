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

ActiveRecord::Schema.define(version: 20160815072019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lens_infos", force: :cascade do |t|
    t.string   "raw_lens"
    t.string   "raw_lens_id"
    t.string   "custom_lens"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["raw_lens", "raw_lens_id"], name: "index_lens_infos_on_raw_lens_and_raw_lens_id", unique: true, using: :btree
  end

  create_table "model_infos", force: :cascade do |t|
    t.string   "raw_model"
    t.string   "custom_model"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["raw_model"], name: "index_model_infos_on_raw_model", unique: true, using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "file_name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "border_style",  default: "black", null: false
    t.string   "model"
    t.string   "lens"
    t.string   "f_number"
    t.string   "focal_length"
    t.string   "exposure_time"
    t.string   "iso"
    t.string   "lens_id"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_pictures_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "pictures", "users"
end
