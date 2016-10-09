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

ActiveRecord::Schema.define(version: 20161004033113) do

  create_table "hosts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hosts_on_user_id"
  end

  create_table "peer_reviews", force: :cascade do |t|
    t.string   "reviewer_id"
    t.integer  "organization_score"
    t.integer  "expertise_score"
    t.integer  "professionalism_score"
    t.integer  "time_management_score"
    t.integer  "cooperation_score"
    t.integer  "communication_score"
    t.integer  "people_skills_score"
    t.integer  "service_score"
    t.text     "comments"
    t.integer  "serviceprovider_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["serviceprovider_id"], name: "index_peer_reviews_on_serviceprovider_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "state_province"
    t.string   "zip_postal_code"
    t.string   "country_region"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "reviewer_id"
    t.integer  "rating_score"
    t.text     "comments"
    t.integer  "serviceprovider_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["serviceprovider_id"], name: "index_reviews_on_serviceprovider_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string   "service_category"
    t.string   "company"
    t.string   "business_phone"
    t.string   "fax"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_service_providers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "activation_digest"
    t.boolean  "activated",              default: false
    t.datetime "activated_at"
    t.string   "remember_digest"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
