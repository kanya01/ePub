class AddCurrentSignInIpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_sign_in_ip, :string
  end
end
