class ChangeDocumentTable < ActiveRecord::Migration[5.1]
  def change
      add_column :documents, :is_archived, :boolean, :default => '0'
  end
end
