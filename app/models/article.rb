class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :section

  validates :user_id, :presence => true

end
