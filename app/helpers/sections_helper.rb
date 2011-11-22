module SectionsHelper
  
  def all_sections_as_text_paths
    sections = Section.all
    section_paths = sections.map(&:fullpath)
  end

  def all_sections_as_text_paths_with_id
    paths = all_sections_as_text_paths.map do |p|
      [p.map(&:name).join('/'), p.last.id]
    end
    # paths.sort! {|a,b| a.first.last <=> b.first.last}
  end
  
  def toplevel_sections_list
    toplevel_sections = Section.find_all_by_parent_id(1);
    toplevel_sections.map do |s|
      ["<li>", link_to(s.name, section_path(s)), "</li>"].join
    end.join.html_safe
  end
  
end
