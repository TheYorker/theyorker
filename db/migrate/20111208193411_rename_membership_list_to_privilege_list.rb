class RenameMembershipListToPrivilegeList < ActiveRecord::Migration
  def change
    rename_table :membership_lists, :privilege_lists
  end
end
