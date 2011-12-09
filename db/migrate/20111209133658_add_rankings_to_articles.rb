class AddRankingsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :importance, :integer, :default => 5
    add_column :articles, :featuredness, :integer, :default => 0
  end
end
