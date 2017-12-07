class AddDefaultState < ActiveRecord::Migration[5.1]
  def change
    change_column :documents, :state, :int, :default => 0, :limit => 2
  end
end
