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

ActiveRecord::Schema[8.0].define(version: 2025_01_15_201241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publication_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "publication_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_bookmarks_on_publication_id"
    t.index ["user_id"], name: "index_publication_bookmarks_on_user_id"
  end

  create_table "publication_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "publication_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_comments_on_publication_id"
    t.index ["user_id"], name: "index_publication_comments_on_user_id"
  end

  create_table "publication_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "publication_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_likes_on_publication_id"
    t.index ["user_id"], name: "index_publication_likes_on_user_id"
  end

  create_table "publication_sources", force: :cascade do |t|
    t.bigint "publication_id", null: false
    t.bigint "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id", "source_id"], name: "index_publication_sources_on_publication_id_and_source_id", unique: true
    t.index ["publication_id"], name: "index_publication_sources_on_publication_id"
    t.index ["source_id"], name: "index_publication_sources_on_source_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "keywords"
    t.integer "readability_score"
    t.integer "word_count"
    t.integer "summary_word_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ai_generated", default: false
    t.integer "read_time"
    t.text "content"
    t.string "category"
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_publications_on_author_id"
  end

  create_table "sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.index ["name"], name: "index_sources_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.string "location"
    t.string "website"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.string "unconfirmed_email"
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count"
    t.boolean "ai_bot"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "publication_bookmarks", "users"
  add_foreign_key "publication_comments", "users"
  add_foreign_key "publication_likes", "users"
  add_foreign_key "publication_sources", "sources"
end
