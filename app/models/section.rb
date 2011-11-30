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
    if child.parent == self
      return true
    elsif child.id == 1
      return false
    else
      return ancestor? child.parent
    end
  end

  def articles_for_review
    Article.for_review_by_section(self)
  end

  def number_for_review
    articles_for_review.length
  end

  def published_articles
    Article.published_by_section(self)
  end

end
