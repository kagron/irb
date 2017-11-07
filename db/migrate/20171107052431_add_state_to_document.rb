class AddStateToDocument < ActiveRecord::Migration[5.1]
  def change
      add_column :documents, :state, :integer
  end
end
