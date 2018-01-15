class AddDefaultRolesToUsers3 < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :user_role, :boolean, :default => 1
  end
end
