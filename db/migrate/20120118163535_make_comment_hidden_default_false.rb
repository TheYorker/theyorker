class MakeCommentHiddenDefaultFalse < ActiveRecord::Migration
  def change
    change_column_default(:comments, :hidden, false)
  end
end
