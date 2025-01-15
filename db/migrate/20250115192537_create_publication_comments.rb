class CreatePublicationComments < ActiveRecord::Migration[8.0]
  def change
    create_table :publication_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :publication, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
