class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.integer :user_id
      t.integer :section_id

      t.timestamps
    end
  end
end
