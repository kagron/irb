class AddFlagToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :is_resubmitted, :boolean
  end
end
