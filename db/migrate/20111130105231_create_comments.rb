class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :byline
      t.text :body
      t.boolean :hidden

      t.timestamps
    end
  end
end
