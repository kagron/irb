class AddDefaultRole < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :user_role, :int, :default => 1
  end
end
