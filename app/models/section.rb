class Section < ActiveRecord::Base

  has_many :articles
  has_many :editors
  has_many :users, :through => :editors

  belongs_to :parent, :class_name => 'Section'

  # given a list of sections, return a list of those sections which
  # are descendants of no sections in the list
  def self.toplevels(sections)
    results = []
    sections.each do |s|
      if !sections.any? {|a| (a != s) && (a.ancestor? s)}
        results.unshift(s)
      end
    end        
    results
  end

  def children
    Section.find_all_by_parent_id(id)
  end
  
  def descendants
    if self.children.empty?
      return
    end
    results = self.children.map do |s|
      s.descendants
    end
    results += self.children
  end

  # list of all sections from root section to this section
  def fullpath
    path = []
    path.unshift(self)
    while path.first.id != 1
      path.unshift(path.first.parent)
    end
    path
  end

  # is this section the ancestor of _child_
  def ancestor?(child)
    if self.id == 1
      return true
    elsif child.parent == self
      return true
    elsif child.id == 1
      return false
    else
      return ancestor? child.parent
    end
  end

  def number_for_review
    review_articles.length
  end

  def review_articles
    Article.review_for_section(self)
  end

  def queued_articles
    Article.queued_for_section(self)
  end

  def published_articles
    Article.published_for_section(self)
  end

  def latest_articles(limit=5)
    Article.latest_published_by_section(self,limit)
  end

  def latest_articles_from_children(limit=5)
    articles = self.latest_articles(limit)
    self.children.each do |s|
      articles += s.latest_articles_from_children
    end
    articles.sort! { |a,b| b.publish_at <=> a.publish_at }
    articles[0,limit] || []
  end

  def latest_articles_from_children_by_rank(limit=5)
    articles = self.latest_articles_from_children(limit*5)
    articles.sort! { |a,b| b.rank <=> a.rank }
    articles[0,limit] || []
  end

  def top_article_from_children
    latest_articles_from_children_by_rank[0]
  end

  def latest_non_top_articles_from_children(limit=5)
    latest_articles_from_children_by_rank(limit)[1..-1] || []
  end

  def headline_articles
    articles = []
    children.each do |c|
      articles << c.top_article_from_children
    end
    articles
  end

end
