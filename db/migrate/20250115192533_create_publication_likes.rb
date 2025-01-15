class CreatePublicationLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :publication_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :publication, null: false, foreign_key: true

      t.timestamps
    end
  end
end
