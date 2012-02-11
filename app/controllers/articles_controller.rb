class ArticlesController < ApplicationController

  layout "member", :except => [:show, :index]

  before_filter :find_article, :only => ['show', 'edit', 'update', 'review', 'publish']
  before_filter :owner_access, :only => ['edit']
  before_filter :editor_access, :only => ['review', 'publish']
  before_filter :owner_or_editor_access, :only => ['update']
  before_filter :check_visibility, :only => ['show']


  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if params[:preview_button]
      render "new"
      return
    end
    if current_user
      @article.user = current_user
    end
    save_and_redirect(params)
  end

  def show

    # THIS IS A HACK:
    # forward requests with an id of less than 10000 to legacy_articles
    if Integer(params[:id]) < 10000
      redirect_to legacy_article_path(@article)
      return
    end
    
    render :layout => "application"
  end
  
  def edit
  end

  def review
  end

  # we really need to refactor this
  def update
    @article.attributes = params[:article]
    if params[:preview_button]
      render view_to_render(params)
      return
    end
    save_and_redirect(params)
  end

  def publish
  end

  def index
    @articles = Section.find(1).latest_articles_from_children
    render :layout => 'application'
  end

  private

  def view_to_render(params)
    params[:review] ? 'review' : 'edit'
  end

  def find_article
    if Integer(params[:id]) >= 10000
      @article = Article.find(params[:id])
    else
      @article = LegacyArticle.find_by_old_id(params[:id])
    end
  end

  def is_owner
    (current_user && @article && @article.user == current_user)
  end

  def is_editor
    (current_user && @article && current_user.editor_for(@article.section))
  end

  def owner_access
    is_owner || render_403
  end

  def editor_access
    is_editor || render_403
  end

  def owner_or_editor_access
    is_owner || is_editor || render_403
  end

  def check_visibility
    is_owner && return
    is_editor && @article.visibility >= 2 && return
    @article.visibility < 3 && render_403
  end

  def save_and_redirect(params)
    if @article.save
      flash.now.notice = "Article saved successfully"
      if params[:confirm_publication_button]
        redirect_to publish_article_path(@article)
      elsif params[:publish_button]
        @article.publish
        redirect_to edit_section_path(@article.section)
      elsif params[:withdraw_from_publication_button]
        @article.withdraw_from_publication
        redirect_to edit_section_path(@article.section)
      elsif params[:submit_for_review_button]
        @article.submit_for_review
        redirect_to articles_user_path(current_user)
      elsif params[:withdraw_button]
        @article.withdraw
        redirect_to articles_user_path(current_user)
      else
        if view_to_render(params) == 'edit'
          redirect_to edit_article_path(@article)
        else
          redirect_to review_article_path(@article)
        end
      end
    else
      flash.now.alert = "Unable to save article"
      render view_to_render(params)
    end
  end

end
