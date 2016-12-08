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

ActiveRecord::Schema.define(version: 20161205202923) do

  create_table "bookings", force: :cascade do |t|
    t.date     "booked_date"
    t.integer  "event_id"
    t.integer  "service_provider_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "offer_id"
    t.index ["event_id"], name: "index_bookings_on_event_id"
    t.index ["service_provider_id"], name: "index_bookings_on_service_provider_id"
  end

  create_table "event_order_details", force: :cascade do |t|
    t.date     "service_date"
    t.time     "service_start_time"
    t.time     "service_end_time"
    t.string   "function"
    t.string   "service_location"
    t.text     "service_setup_requirements"
    t.integer  "event_order_id"
    t.integer  "service_id"
    t.integer  "service_provider_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["event_order_id"], name: "index_event_order_details_on_event_order_id"
    t.index ["service_id"], name: "index_event_order_details_on_service_id"
    t.index ["service_provider_id"], name: "index_event_order_details_on_service_provider_id"
  end

  create_table "event_orders", force: :cascade do |t|
    t.date     "order_date"
    t.string   "primary_onsite_contact"
    t.string   "secondary_onsite_contact"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.integer  "event_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["event_id"], name: "index_event_orders_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.date     "event_date"
    t.time     "event_start_time"
    t.time     "event_end_time"
    t.string   "street_address"
    t.string   "city"
    t.string   "state_province"
    t.string   "zip_postal_code"
    t.string   "country_region"
    t.string   "event_contact"
    t.text     "comments"
    t.boolean  "publish_on_marketplace"
    t.integer  "host_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "venue"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "event_manager_id"
    t.index ["host_id"], name: "index_events_on_host_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date     "expense_date"
    t.string   "expense_source"
    t.text     "notes"
    t.integer  "event_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "budgeted_amount"
    t.float    "actual_amount"
    t.index ["event_id"], name: "index_expenses_on_event_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "portfolio_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["portfolio_id"], name: "index_galleries_on_portfolio_id"
  end

  create_table "guest_lists", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "total_attendees_expected"
    t.string   "seating_arrangement"
    t.text     "notes"
    t.integer  "event_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["event_id"], name: "index_guest_lists_on_event_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hosts_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.date     "income_date"
    t.string   "income_source"
    t.float    "expected_amount"
    t.float    "actual_amount"
    t.text     "notes"
    t.integer  "event_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["event_id"], name: "index_incomes_on_event_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "opening_tag_line"
    t.string   "groom_tag_line"
    t.string   "mid_tag_line"
    t.string   "bride_tag_line"
    t.string   "event_tag_line"
    t.string   "gift_tag_line"
    t.string   "closing_tag_line"
    t.integer  "event_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "groom_tagline2"
    t.string   "bride_tagline2"
    t.string   "mid_tagline2"
    t.integer  "event_two_id"
    t.integer  "event_three_id"
    t.string   "gift_tagline2"
    t.string   "gift_tagline3"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["event_id"], name: "index_invitations_on_event_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "quantity"
    t.integer  "menu_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "event_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "service_type"
    t.boolean  "require_reservation"
    t.index ["event_id"], name: "index_menus_on_event_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.text     "details"
    t.text     "terms_conditions"
    t.date     "expires"
    t.integer  "service_provider_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "original_price"
    t.index ["service_provider_id"], name: "index_offers_on_service_provider_id"
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

  create_table "pictures", force: :cascade do |t|
    t.integer  "gallery_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["gallery_id"], name: "index_pictures_on_gallery_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "tag_line"
    t.text     "bio"
    t.string   "website"
    t.text     "work_experience"
    t.text     "achievements"
    t.text     "area_of_expertise"
    t.text     "services_offered"
    t.text     "works_projects"
    t.integer  "service_provider_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["service_provider_id"], name: "index_portfolios_on_service_provider_id"
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
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.text    "rfq_contact"
    t.text    "rfq_delivery_method"
    t.text    "services_requested"
    t.text    "comments"
    t.integer "event_id"
    t.text    "created_at",          null: false
    t.text    "updated_at",          null: false
    t.date    "rfq_issue_date"
    t.date    "rfq_closing_date"
    t.index ["event_id"], name: "index_quotations_on_event_id", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "complete_address"
    t.string   "primary_phone"
    t.boolean  "attending_event"
    t.integer  "total_attending"
    t.string   "food_choice"
    t.integer  "kids_meal_required"
    t.boolean  "food_allergies"
    t.text     "special_notes"
    t.integer  "event_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "need_paper_invitation"
    t.index ["event_id"], name: "index_reservations_on_event_id"
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

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"
  end

  create_table "service_provider_services", id: false, force: :cascade do |t|
    t.integer "service_provider_id"
    t.integer "service_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string   "company"
    t.string   "business_phone"
    t.string   "fax"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "namlo_partner"
    t.boolean  "namlo_preferred"
    t.index ["user_id"], name: "index_service_providers_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "service_name"
    t.text     "service_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "survey_question_responses", force: :cascade do |t|
    t.string  "response"
    t.integer "survey_id"
    t.integer "survey_question_id"
    t.index ["survey_id"], name: "index_survey_question_responses_on_survey_id"
    t.index ["survey_question_id"], name: "index_survey_question_responses_on_survey_question_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.text     "question"
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "to_do_items", force: :cascade do |t|
    t.string   "todo_item"
    t.datetime "completed_at"
    t.integer  "to_do_list_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["to_do_list_id"], name: "index_to_do_items_on_to_do_list_id"
  end

  create_table "to_do_lists", force: :cascade do |t|
    t.string   "todo_list_title"
    t.text     "todo_list_description"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["user_id"], name: "index_to_do_lists_on_user_id"
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
