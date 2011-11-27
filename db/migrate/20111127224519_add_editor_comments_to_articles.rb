class AddEditorCommentsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :editor_comments, :text
  end
end
