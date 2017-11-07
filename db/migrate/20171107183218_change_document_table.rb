class ChangeDocumentTable < ActiveRecord::Migration[5.1]
  def change
      add_column :documents, :is_archived, :integer, :limit => 2
  end
end
