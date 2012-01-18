class Comment < ActiveRecord::Base

  belongs_to :article
  belongs_to :user

  def self.recent(limit=5)
    Comment.order('created_at DESC').where("hidden = ? OR ?", false, nil).limit(limit)
  end

  def hide
    self.hidden = true
    self.save
  end

  def unhide
    self.hidden = false
    self.save
  end

end
