class ArticlesController < ApplicationController

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
    if @article.save
      flash.now.notice = "Article saved successfully"
      redirect_to user_path(current_user)
    else
      flash.now.alert = "Unable to save article"
      render "new"
    end
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  # we really need to refactor this
  def update
    @article = Article.find(params[:id])
    @article.attributes = params[:article]
    if params[:preview_button]
      render view_to_render(params)
      return
    end
    if @article.save
      flash.now.notice = "Article saved successfully"
      if params[:publish_button]
        @article.publish
      elsif params[:submit_for_review_button]
        @article.submit_for_review
      elsif params[:withdraw_button]
        @article.withdraw
      elsif params[:withdraw_from_publication_button]
        @article.withdraw_from_publication
      end
      redirect_to article_path(@article)
    else
      flash.now.alert = "Unable to save article"
      render view_to_render(params)
    end
  end

  def review
    @article = Article.find(params[:id])
  end
  
  #private
  
  def view_to_render(params)
    params[:review] ? 'review' : 'edit'
  end

end
