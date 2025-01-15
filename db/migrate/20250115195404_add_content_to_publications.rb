class AddContentToPublications < ActiveRecord::Migration[8.0]
  def change
    add_column :publications, :content, :text
  end
end
