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

ActiveRecord::Schema.define(version: 20171024131619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "choice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["choice_id"], name: "index_answers_on_choice_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "choices", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "choice"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_choices_on_question_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "question"
    t.boolean  "mcq"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "expire_at"
    t.boolean  "allow_reuse"
    t.string   "slug"
    t.date     "expiry"
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.uuid     "uuid"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secret"], name: "index_users_on_secret", using: :btree
    t.index ["uuid"], name: "index_users_on_uuid", using: :btree
  end

  add_foreign_key "answers", "choices"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "questions", "users"
end
