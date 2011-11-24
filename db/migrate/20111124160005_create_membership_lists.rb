class CreateMembershipLists < ActiveRecord::Migration
  def change
    create_table :membership_lists do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.text :addresses

      t.timestamps
    end
  end
end
