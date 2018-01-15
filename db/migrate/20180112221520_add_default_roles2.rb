class AddDefaultRoles2 < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :user_role, :tinyint, :default => 1, :limit => 1
  end
end
