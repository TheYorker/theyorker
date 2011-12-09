class CommentsController < ApplicationController

  before_filter :admin_access, :only => ['hide', 'unhide']

  def create
    if !current_user
      flash.now.error = "Must be logged in to post comments"
      redirect_to article_path(article)
      return
    end
    article = Article.find(params[:id])
    comment = article.comments.create(params[:comment])
    comment.user = current_user
    comment.save
    redirect_to article_path(article)
  end

  def hide
    comment = Comment.find(params[:id])
    comment.hide
    redirect_to article_path(comment.article)
  end

  def unhide
    comment = Comment.find(params[:id])
    comment.unhide
    redirect_to article_path(comment.article)
  end

end
