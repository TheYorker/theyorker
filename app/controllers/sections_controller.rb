class SectionsController < ApplicationController

  before_filter :member_access, :except => ['show', 'index']

  def new
    @potential_parents = Section.all
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      flash.now.notice = "Section created"
      redirect_to edit_section_path(@section.parent)
    else
      flash.now.notice = "Unable to create section"
      render edit_section_path(@section.parent)
    end
  end

  def show
    @section = Section.find(params[:id])
  end
  
  def index
    @toplevel_sections = Section.find_all_by_parent_id(1);
  end

  def edit
    @section = Section.find(params[:id])
    render :layout => 'member'
  end

end

