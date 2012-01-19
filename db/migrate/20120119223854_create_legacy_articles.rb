class CreateLegacyArticles < ActiveRecord::Migration
  def change
    create_table :legacy_articles do |t|
      t.integer :old_id
      t.string :title
      t.integer :section_id
      t.integer :user_id
      t.text :potential_paths
      t.string :author_email
      t.string :byline
      t.string :tagline
      t.text :body
      t.timestamp :publish_at

      t.timestamps
    end
  end
end
