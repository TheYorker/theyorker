class Section < ActiveRecord::Base

  has_many :articles

  belongs_to :parent, :class_name => 'Section'

  def children
    Section.find_all_by_parent_id(id)
  end

  def fullpath
    path = []
    path.unshift(self)
    while path.first.id != 1
      path.unshift(path.first.parent)
    end
    path
  end

end
