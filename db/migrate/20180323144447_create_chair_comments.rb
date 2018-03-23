class CreateChairComments < ActiveRecord::Migration[5.1]
  def change
    create_table :chair_comments do |t|
      t.text :body
      t.integer :document_id
      t.index :document_id
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
