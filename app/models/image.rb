class Image < ActiveRecord::Base
  has_attached_file :picture, :styles => {:headline => '800x500',
                                          :medium => '300x300',
                                          :large_thumb => '150x150',
                                          :small_thumb => '50x50'}

  validates :title, :presence => :true
  validates :copyright_owner, :presence => :true
  validates :picture_file_name, :presence => :true
  

end
