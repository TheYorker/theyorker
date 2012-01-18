class AddPictureMetaToImage < ActiveRecord::Migration
  def change
    add_column :images, :picture_meta, :text
  end
end
