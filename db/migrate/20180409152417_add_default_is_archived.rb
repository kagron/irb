class AddDefaultIsArchived < ActiveRecord::Migration[5.1]
  def change
    change_column :documents, :is_archived, :boolean, :default => false
  end
end
