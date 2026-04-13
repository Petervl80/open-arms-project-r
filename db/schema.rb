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

ActiveRecord::Schema[8.1].define(version: 2026_04_13_203725) do
  create_table "action_plan_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "activity", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id", null: false
    t.index ["child_id"], name: "index_action_plan_items_on_child_id"
    t.index ["updated_by_id"], name: "index_action_plan_items_on_updated_by_id"
  end

  create_table "blood_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_blood_types_on_description", unique: true
  end

  create_table "child_contact_roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_child_contact_roles_on_description", unique: true
  end

  create_table "child_contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "child_contact_role_id", null: false
    t.bigint "child_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.boolean "is_primary", default: false
    t.integer "sequence"
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id", null: false
    t.index ["child_contact_role_id"], name: "index_child_contacts_on_child_contact_role_id"
    t.index ["child_id", "contact_id"], name: "index_child_contacts_on_child_id_and_contact_id", unique: true
    t.index ["child_id"], name: "index_child_contacts_on_child_id"
    t.index ["contact_id"], name: "index_child_contacts_on_contact_id"
    t.index ["updated_by_id"], name: "index_child_contacts_on_updated_by_id"
  end

  create_table "children", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "birth_date"
    t.bigint "blood_type_id"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.string "full_name", null: false
    t.string "nationality"
    t.string "naturalness"
    t.text "observations"
    t.string "process_number"
    t.bigint "race_type_id"
    t.string "rg"
    t.bigint "sex_type_id"
    t.datetime "updated_at", null: false
    t.index ["blood_type_id"], name: "index_children_on_blood_type_id"
    t.index ["cpf"], name: "index_children_on_cpf", unique: true
    t.index ["full_name"], name: "index_children_on_full_name"
    t.index ["process_number"], name: "index_children_on_process_number", unique: true
    t.index ["race_type_id"], name: "index_children_on_race_type_id"
    t.index ["sex_type_id"], name: "index_children_on_sex_type_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "city", limit: 50
    t.datetime "created_at", null: false
    t.string "district", limit: 50
    t.bigint "family_side_id"
    t.string "full_name", limit: 50, null: false
    t.text "notes"
    t.string "occupation", limit: 30
    t.string "phone", limit: 20
    t.string "state", limit: 30
    t.string "street", limit: 50
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id", null: false
    t.index ["family_side_id"], name: "index_contacts_on_family_side_id"
    t.index ["updated_by_id"], name: "index_contacts_on_updated_by_id"
  end

  create_table "family_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.text "description"
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id", null: false
    t.index ["child_id"], name: "index_family_events_on_child_id"
    t.index ["updated_by_id"], name: "index_family_events_on_updated_by_id"
  end

  create_table "family_sides", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_family_sides_on_description", unique: true
  end

  create_table "file_assets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content_type", null: false
    t.datetime "created_at", null: false
    t.string "file_name", null: false
    t.bigint "file_type_id", null: false
    t.bigint "size", null: false
    t.string "storage_path", null: false
    t.datetime "updated_at", null: false
    t.index ["file_type_id"], name: "index_file_assets_on_file_type_id"
  end

  create_table "file_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_file_types_on_description", unique: true
  end

  create_table "health_event_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_health_event_types_on_description", unique: true
  end

  create_table "individual_care_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_individual_care_types_on_description", unique: true
  end

  create_table "individual_cares", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.bigint "individual_care_type_id", null: false
    t.text "notes"
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id", null: false
    t.index ["child_id"], name: "index_individual_cares_on_child_id"
    t.index ["individual_care_type_id"], name: "index_individual_cares_on_individual_care_type_id"
    t.index ["updated_by_id"], name: "index_individual_cares_on_updated_by_id"
  end

  create_table "permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_permissions_on_description"
  end

  create_table "permissions_roles", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "process_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_process_types_on_description", unique: true
  end

  create_table "race_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_race_types_on_description", unique: true
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_roles_on_description"
  end

  create_table "roles_user_accounts", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_account_id", null: false
  end

  create_table "school_event_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_school_event_types_on_description", unique: true
  end

  create_table "sex_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_sex_types_on_description", unique: true
  end

  create_table "user_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "account_non_expired", default: true
    t.boolean "account_non_locked", default: true
    t.datetime "created_at", null: false
    t.boolean "credentials_non_expired", default: true
    t.string "email", null: false
    t.boolean "enabled", default: true
    t.string "full_name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
  end

  add_foreign_key "action_plan_items", "children"
  add_foreign_key "action_plan_items", "user_accounts", column: "updated_by_id"
  add_foreign_key "child_contacts", "child_contact_roles"
  add_foreign_key "child_contacts", "children"
  add_foreign_key "child_contacts", "contacts"
  add_foreign_key "child_contacts", "user_accounts", column: "updated_by_id"
  add_foreign_key "children", "blood_types"
  add_foreign_key "children", "race_types"
  add_foreign_key "children", "sex_types"
  add_foreign_key "contacts", "family_sides"
  add_foreign_key "contacts", "user_accounts", column: "updated_by_id"
  add_foreign_key "family_events", "children"
  add_foreign_key "family_events", "user_accounts", column: "updated_by_id"
  add_foreign_key "file_assets", "file_types"
  add_foreign_key "individual_cares", "children"
  add_foreign_key "individual_cares", "individual_care_types"
  add_foreign_key "individual_cares", "user_accounts", column: "updated_by_id"
end
