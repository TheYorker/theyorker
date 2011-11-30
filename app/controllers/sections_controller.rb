class SectionsController < ApplicationController

  def new
    @potential_parents = Section.all
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      flash.now.notice = "Section created"
      redirect_to sections_path
    else
      flash.now.notice = "Unable to create section"
      render "new"
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

