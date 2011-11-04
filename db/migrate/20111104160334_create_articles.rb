class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :section_id
      t.string :title
      t.text :body
      t.timestamp :publish_at
      t.integer :visibility

      t.timestamps
    end
  end
end
