class AddUsersToDocuments < ActiveRecord::Migration[5.1]
  def change
    #remove_column :documents, :user_id
    add_column :documents, :user_id, :integer, :limit => 8
    add_index :documents, :user_id
    add_foreign_key :documents, :users
  end
end
