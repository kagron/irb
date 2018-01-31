class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :document_id
      t.index :document_id
      t.integer :user_id
      t.index :user_id
      t.integer :state
      t.timestamps
    end
  end
end
