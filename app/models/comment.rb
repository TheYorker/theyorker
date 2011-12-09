class Comment < ActiveRecord::Base

  belongs_to :article
  belongs_to :user

  def hide
    self.hidden = true
    self.save
  end

  def unhide
    self.hidden = false
    self.save
  end

end
