class CommentsController < ApplicationController

  before_filter :admin_access, :only => ['hide', 'unhide']

  def create
    article = Article.find(params[:id])
    comment = article.comments.create(params[:comment])
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
