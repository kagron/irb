class ChangeDocument < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :written_permission
    add_column :documents, :written_permission_file, :string
  end
end
