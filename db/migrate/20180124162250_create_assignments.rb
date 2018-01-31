class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.belongs_to :documents, index: true
      t.belongs_to :users, index: true
      t.timestamps
    end
  end
end
