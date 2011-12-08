class AddTypeToPrivilegeList < ActiveRecord::Migration
  def change
    add_column :privilege_lists, :type, :integer
  end
end
