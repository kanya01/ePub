class AddAiFieldsToPublications < ActiveRecord::Migration[7.0]
  def change
    add_column :publications, :ai_generated, :boolean, default: false
    add_column :publications, :read_time, :integer
  end
end