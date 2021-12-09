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

ActiveRecord::Schema.define(version: 2021_12_09_230659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "habit_entries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "habit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_entries_on_habit_id"
    t.index ["user_id"], name: "index_habit_entries_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "journal_entries", force: :cascade do |t|
    t.datetime "date"
    t.string "content"
    t.bigint "user_id"
    t.bigint "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_journal_entries_on_journal_id"
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "name"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moods", force: :cascade do |t|
    t.integer "mood"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_moods_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "habit_entries", "habits"
  add_foreign_key "habit_entries", "users"
  add_foreign_key "journal_entries", "journals"
  add_foreign_key "journal_entries", "users"
  add_foreign_key "moods", "users"
end
