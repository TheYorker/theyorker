class Article < ActiveRecord::Base

  DRAFT   = 1
  REVIEW  = 2
  PUBLISH = 3

  belongs_to :user
  belongs_to :section

  has_many :comments

  belongs_to :image

  validates :user_id, :presence => true

  #  featured articles
  def self.featured(limit=5)
    recent = Section.find(1).latest_articles_from_children(limit*5)
    recent.sort! {|a,b| b.feature_rank <=> a.feature_rank}
    recent[0,limit]
  end

  # article types for users

  def self.draft_for_user(user)
    Article.where(:user_id => user.id, :visibility => 1)
  end
  
  def self.review_for_user(user)
    Article.where(:user_id => user.id, :visibility => 2)
  end
  
  def self.published_for_user(user)
    Article.where(:user_id => user.id, :visibility => 3)
  end

  # article types for sections

  def self.review_for_section(section)
    Article.where(:section_id => section.id, :visibility => 2)
  end
  
  def self.queued_for_section(section)
    Article.where(:section_id => section.id,
                  :visibility => 3).where("publish_at > ?", Time.now)
  end

  def self.published_for_section(section)
    Article.where(:section_id => section.id,
                  :visibility => 3).where("publish_at <= ?", Time.now)
  end

  def self.latest_published_by_section(section, limit=5)
    Article
      .where(:section_id => section.id,
             :visibility => 3).where("publish_at <= ?", Time.now)
      .order('publish_at DESC')
      .limit(limit)
  end

  def related_articles(limit=5)
    query = self.tag.split(/\W/).delete_if(&:empty?).join("|")
    articles = Article.search(query)
    articles[0,limit]
  end

  def submit_for_review
    self.visibility = REVIEW
    self.save
  end

  def withdraw
    self.visibility = DRAFT
    self.save
  end

  def publish
    self.visibility = PUBLISH
    self.save
  end

  def published?
    self.visibility == PUBLISH
  end

  def withdraw_from_publication
    if self.visibility == PUBLISH
      self.visibility = REVIEW
    end
    self.save
  end

  def rank
    self.importance - age_in_days
  end

  def feature_rank
    self.featuredness - age_in_days
  end

  def headline_image
    self.image ? self.image.picture.url(:headline) : 'ylogo_headline.png'
  end

  def headline_image_width
    self.image ? self.image.picture.width(:headline) : '80%';
  end

  def medium_image
    self.image ? self.image.picture.url(:medium) : 'ylogo_medium.png'
  end

  def thumbnail
    self.image ? self.image.picture.url(:large_thumb) : 'ylogo.png'
  end
  
  def small_thumbnail
    self.image ? self.image.picture.url(:small_thumb) : 'ylogo_small_thumb.png'
  end

  def date_string
    self.publish_at ? self.publish_at.to_date.to_formatted_s(:long_ordinal) : ""
  end

  private

  def age_in_days
    (Time.now - self.publish_at) / 1.day
  end

end
