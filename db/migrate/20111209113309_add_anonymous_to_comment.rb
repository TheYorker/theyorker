class AddAnonymousToComment < ActiveRecord::Migration
  def change
    add_column :comments, :anonymous, :boolean, :default => false
  end
end
