class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email

  has_many :articles
  has_many :editors
  has_many :sections, :through => :editors

  def draft_articles
    Article.draft_for_user(self)
  end

  def review_articles
    Article.review_for_user(self)
  end

  def published_articles
    Article.published_for_user(self)
  end

  def editor_for(section)
    self.sections.any? {|s| s.ancestor?(section) || s == section}
  end

  def toplevel_editor?
    self.editor_for(Section.find(1))
  end

  def suspend
    self.suspended = true
    self.save
  end

  def unsuspend
    self.suspended = false
    self.save
  end

end
