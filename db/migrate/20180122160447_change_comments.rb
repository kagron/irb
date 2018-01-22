class ChangeComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :documents_id
    add_column :comments, :document_id, :integer, :limit => 8
    add_index :comments, :document_id
    add_foreign_key :comments, :documents
    remove_column :comments, :users_id
    add_column :comments, :user_id, :integer, :limit => 8
    add_index :comments, :user_id
    add_foreign_key :comments, :users
  end
end
