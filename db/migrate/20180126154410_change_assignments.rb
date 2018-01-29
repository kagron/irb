class ChangeAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :document_id, :integer, :limit => 8
    add_index :assignments, :document_id
    add_foreign_key :assignments, :documents
    add_column :assignments, :user_id, :integer, :limit => 8
    add_index :assignments, :user_id
    add_foreign_key :assignments, :users
  end
end
