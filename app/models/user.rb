class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email

  has_many :articles
  has_many :editors
  has_many :sections, :through => :editors

  def pending_articles
    Article.pending_articles_for_user(self)
  end

end
