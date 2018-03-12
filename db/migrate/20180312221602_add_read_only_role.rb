class AddReadOnlyRole < ActiveRecord::Migration[5.1]
  def change

    add_column :users, :readonly_role, :boolean

  end
end
