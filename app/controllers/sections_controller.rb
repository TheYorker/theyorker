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
    if @section.leaf?
      @articles = @section.latest_articles_from_children(15)
      render 'show_leaf'
      return
    end
  end
  
  ## DEPRECATED
  def index
    @toplevel_sections = Section.find_all_by_parent_id(1);
  end

  def edit
    @section = Section.find(params[:id])
    @review_articles = @section.review_articles.paginate :page => params[:review_page], :per_page => 10
    @queued_articles = @section.queued_articles.paginate :page => params[:queued_page], :per_page => 10
    @published_articles = @section.published_articles.paginate :page => params[:published_page], :per_page => 10
    render :layout => 'member'
  end

end

