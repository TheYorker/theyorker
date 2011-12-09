class AddTaglineToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :tagline, :string
  end
end
