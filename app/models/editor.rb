class Editor < ActiveRecord::Base

  belongs_to :user
  belongs_to :section
  
end
