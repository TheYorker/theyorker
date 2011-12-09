class Comment < ActiveRecord::Base

  belongs_to :article

  def check_byline
    if self.byline.empty?
      self.byline = "Anonymous"
    end
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
