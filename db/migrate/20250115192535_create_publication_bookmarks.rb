class CreatePublicationBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :publication_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :publication, null: false, foreign_key: true

      t.timestamps
    end
  end
end
