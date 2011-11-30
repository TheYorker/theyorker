class Comment < ActiveRecord::Base

  belongs_to :article

  def check_byline
    if self.byline.empty?
      self.byline = "Anonymous"
    end
  end

end
