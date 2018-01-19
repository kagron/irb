class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :fname
      t.string :lname
      t.text :content
      t.belongs_to :documents, index: true
      t.belongs_to :users, index: true
      t.timestamps
    end
  end
end
