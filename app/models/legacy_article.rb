class LegacyArticle < ActiveRecord::Base

  belongs_to :user
  belongs_to :section

  def date_string
    self.publish_at ? self.publish_at.to_date.to_formatted_s(:long_ordinal) : ""
  end
  
  def visibility
    return 3
  end

end
