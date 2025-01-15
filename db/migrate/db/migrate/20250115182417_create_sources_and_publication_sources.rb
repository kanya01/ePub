class CreateSourcesAndPublicationSources < ActiveRecord::Migration[7.0]
  def change
    add_column :sources, :name, :string, null: false
    add_column :sources, :url, :string, null: false

    create_table :publication_sources do |t|
      t.references :publication, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sources, :name, unique: true
    add_index :publication_sources, [:publication_id, :source_id], unique: true
  end
end