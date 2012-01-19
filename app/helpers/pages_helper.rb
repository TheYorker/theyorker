module PagesHelper

  def all_pages_sorted
    Page.order('position ASC')
  end
  
end
