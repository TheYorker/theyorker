class Image < ActiveRecord::Base
  has_attached_file :picture, :styles => {:medium => '300x300',
                                          :large_thumb => '150x150',
                                          :small_thumb => '50x50'}

end
