class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.string :source_url
      t.string :copyright_owner
      t.text :copyright_justification
      t.string :image_credit
      t.boolean :checked

      t.timestamps
    end
  end
end
