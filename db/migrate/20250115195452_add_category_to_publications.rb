class AddCategoryToPublications < ActiveRecord::Migration[8.0]
  def change
    add_column :publications, :category, :string
  end
end
