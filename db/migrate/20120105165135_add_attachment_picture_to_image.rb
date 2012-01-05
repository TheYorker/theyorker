class AddAttachmentPictureToImage < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_atttached_file :images, :picture
  end
end
