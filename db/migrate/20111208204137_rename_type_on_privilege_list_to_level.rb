class RenameTypeOnPrivilegeListToLevel < ActiveRecord::Migration
  def change
    rename_column :privilege_lists, :type, :level
  end
end
