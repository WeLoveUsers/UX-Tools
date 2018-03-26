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

ActiveRecord::Schema.define(version: 20180221130430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_notifications", force: :cascade do |t|
    t.datetime "date"
    t.string   "notification_type"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "questionnaire_id"
    t.string   "questionnaire_language"
    t.string   "product_type"
    t.string   "product_name"
    t.string   "project_code"
    t.datetime "end_date"
    t.string   "uri_token"
    t.integer  "user_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "instructions"
    t.boolean  "is_closed",                default: false
    t.datetime "deleted_at"
    t.boolean  "forbid_multiple_reponses", default: false
    t.boolean  "ask_user_ideas",           default: false
    t.boolean  "ask_user_summary",         default: false
    t.boolean  "ask_user_age",             default: false
    t.boolean  "ask_user_gender",          default: false
    t.boolean  "ask_user_occupation",      default: false
    t.boolean  "ask_user_first_use_date",  default: false
    t.boolean  "ask_user_usage_frequency", default: false
    t.boolean  "ask_user_group",           default: false
    t.index ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree
    t.index ["uri_token"], name: "index_projects_on_uri_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "read_app_notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "app_notification_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["app_notification_id"], name: "index_read_app_notifications_on_app_notification_id", using: :btree
    t.index ["user_id", "app_notification_id"], name: "index_read_app_notifications_on_user_id_and_app_notification_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_read_app_notifications_on_user_id", using: :btree
  end

  create_table "response_attrak_diff_abridgeds", force: :cascade do |t|
    t.integer  "ATT2"
    t.integer  "ATT5"
    t.integer  "QP2"
    t.integer  "QP3"
    t.integer  "QP5"
    t.integer  "QP6"
    t.integer  "QHS2"
    t.integer  "QHS5"
    t.integer  "QHI3"
    t.integer  "QHI4"
    t.string   "respondent_id"
    t.integer  "project_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "deleted_at"
    t.text     "ideas"
    t.text     "summary"
    t.integer  "age",                       default: 0
    t.integer  "gender",                    default: 0
    t.string   "occupation"
    t.datetime "first_use_on"
    t.integer  "usage_frequency_per_month", default: 0
    t.integer  "group",                     default: 0
    t.index ["deleted_at"], name: "index_response_attrak_diff_abridgeds_on_deleted_at", using: :btree
    t.index ["project_id"], name: "index_response_attrak_diff_abridgeds_on_project_id", using: :btree
  end

  create_table "response_attrak_diffs", force: :cascade do |t|
    t.integer  "ATT1"
    t.integer  "ATT2"
    t.integer  "ATT3"
    t.integer  "ATT4"
    t.integer  "ATT5"
    t.integer  "ATT6"
    t.integer  "ATT7"
    t.integer  "QP1"
    t.integer  "QP2"
    t.integer  "QP3"
    t.integer  "QP4"
    t.integer  "QP5"
    t.integer  "QP6"
    t.integer  "QP7"
    t.integer  "QHS1"
    t.integer  "QHS2"
    t.integer  "QHS3"
    t.integer  "QHS4"
    t.integer  "QHS5"
    t.integer  "QHS6"
    t.integer  "QHS7"
    t.integer  "QHI1"
    t.integer  "QHI2"
    t.integer  "QHI3"
    t.integer  "QHI4"
    t.integer  "QHI5"
    t.integer  "QHI6"
    t.integer  "QHI7"
    t.string   "respondent_id"
    t.integer  "project_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "deleted_at"
    t.text     "ideas"
    t.text     "summary"
    t.integer  "age",                       default: 0
    t.integer  "gender",                    default: 0
    t.string   "occupation"
    t.datetime "first_use_on"
    t.integer  "usage_frequency_per_month", default: 0
    t.integer  "group",                     default: 0
    t.index ["deleted_at"], name: "index_response_attrak_diffs_on_deleted_at", using: :btree
    t.index ["project_id"], name: "index_response_attrak_diffs_on_project_id", using: :btree
  end

  create_table "response_deeps", force: :cascade do |t|
    t.integer  "Q1"
    t.integer  "Q2"
    t.integer  "Q3"
    t.integer  "Q4"
    t.integer  "Q5"
    t.integer  "Q6"
    t.integer  "Q7"
    t.integer  "Q8"
    t.integer  "Q9"
    t.integer  "Q10"
    t.integer  "Q11"
    t.integer  "Q12"
    t.integer  "Q13"
    t.integer  "Q14"
    t.integer  "Q15"
    t.integer  "Q16"
    t.integer  "Q17"
    t.integer  "Q18"
    t.integer  "Q19"
    t.string   "respondent_id"
    t.integer  "project_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "deleted_at"
    t.text     "ideas"
    t.text     "summary"
    t.integer  "age",                       default: 0
    t.integer  "gender",                    default: 0
    t.string   "occupation"
    t.datetime "first_use_on"
    t.integer  "usage_frequency_per_month", default: 0
    t.integer  "group",                     default: 0
    t.index ["deleted_at"], name: "index_response_deeps_on_deleted_at", using: :btree
    t.index ["project_id"], name: "index_response_deeps_on_project_id", using: :btree
  end

  create_table "response_sus", force: :cascade do |t|
    t.integer  "Q1"
    t.integer  "Q2"
    t.integer  "Q3"
    t.integer  "Q4"
    t.integer  "Q5"
    t.integer  "Q6"
    t.integer  "Q7"
    t.integer  "Q8"
    t.integer  "Q9"
    t.integer  "Q10"
    t.string   "respondent_id"
    t.integer  "project_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "deleted_at"
    t.text     "ideas"
    t.text     "summary"
    t.integer  "age",                       default: 0
    t.integer  "gender",                    default: 0
    t.string   "occupation"
    t.datetime "first_use_on"
    t.integer  "usage_frequency_per_month", default: 0
    t.integer  "group",                     default: 0
    t.index ["deleted_at"], name: "index_response_sus_on_deleted_at", using: :btree
    t.index ["project_id"], name: "index_response_sus_on_project_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "projects", "users"
  add_foreign_key "read_app_notifications", "app_notifications"
  add_foreign_key "read_app_notifications", "users"
  add_foreign_key "response_attrak_diff_abridgeds", "projects"
  add_foreign_key "response_attrak_diffs", "projects"
  add_foreign_key "response_deeps", "projects"
  add_foreign_key "response_sus", "projects"
end
