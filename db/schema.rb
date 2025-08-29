ActiveRecord::Schema[7.1].define(version: 2025_08_28_075057) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
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
    t.string "end_type"
    t.index ["habit_id"], name: "index_goals_on_habit_id"
  end

  create_table "habit_types", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.string "verb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_habit_types_on_category_id"
  end

  create_table "habit_types_verbs", id: false, force: :cascade do |t|
    t.bigint "habit_type_id", null: false
    t.bigint "verb_id", null: false
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
    t.index ["verb_id"], name: "index_habits_on_verb_id"
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

  add_foreign_key "goals", "habits"
  add_foreign_key "habit_types", "categories"
  add_foreign_key "habits", "habit_types"
  add_foreign_key "habits", "users"
  add_foreign_key "habits", "verbs"
  add_foreign_key "tips", "habits"
  add_foreign_key "tips", "users"
end
