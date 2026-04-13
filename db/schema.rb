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

ActiveRecord::Schema[8.1].define(version: 2026_04_13_194842) do
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

  add_foreign_key "file_assets", "file_types"
end
