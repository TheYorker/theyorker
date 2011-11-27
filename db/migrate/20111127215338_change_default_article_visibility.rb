class ChangeDefaultArticleVisibility < ActiveRecord::Migration
  def change
    change_column_default(:articles, :visibility, 1)
  end
end
