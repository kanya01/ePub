# db/migrate/YYYYMMDDHHMMSS_create_publications.rb
# db/migrate/YYYYMMDDHHMMSS_create_publications.rb
class CreatePublications < ActiveRecord::Migration[7.0]
  def change
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
  end
end