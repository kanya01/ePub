class AddSignInCountToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :sign_in_count, :integer
  end
end
