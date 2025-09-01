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

ActiveRecord::Schema[7.1].define(version: 2025_08_31_101506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.text "informations"
    t.integer "duration"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.string "value"
    t.string "frequency"
    t.date "target_day"
    t.boolean "is_public"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.integer "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "tracking_config", default: {}, null: false
    t.string "end_type"
    t.index ["habit_id"], name: "index_goals_on_habit_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_groups_on_challenge_id"
  end

  create_table "habit_types", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_habit_types_on_category_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.string "visibility"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "habit_type_id"
    t.bigint "category_id"
    t.bigint "verb_id"
    t.index ["category_id"], name: "index_habits_on_category_id"
    t.index ["habit_type_id"], name: "index_habits_on_habit_type_id"
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "habit_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_tips_on_habit_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
  end

  create_table "trackers", force: :cascade do |t|
    t.date "date"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "habit_id"
    t.index ["habit_id"], name: "index_trackers_on_habit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pseudo"
    t.string "avatar"
    t.integer "age"
    t.string "location"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verbs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "challenges", "users"
  add_foreign_key "goals", "habits"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "challenges"
  add_foreign_key "habit_types", "categories"
  add_foreign_key "habits", "habit_types"
  add_foreign_key "habits", "users"
  add_foreign_key "tips", "habits"
  add_foreign_key "tips", "users"
end
