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

  def update
    @article = Article.find(params[:id])
    @article.attributes = params[:article]
    if params[:preview_button]
      render "edit"
      return
    end
    if @article.save
      flash.now.notice = "Article saved successfully"
      redirect_to article_path(@article)
    else
      flash.now.alert = "Unable to save article"
      render "edit"
    end
  end

  def review
    @article = Article.find(params[:id])
  end

end
