class AddAiBotToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :ai_bot, :boolean
  end
end
