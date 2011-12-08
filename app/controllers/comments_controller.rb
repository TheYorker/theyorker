class CommentsController < ApplicationController

  before_filter :is_admin, :only => ['hide', 'unhide']

  def create
    article = Article.find(params[:id])
    comment = article.comments.create(params[:comment])
    redirect_to article_path(article)
  end

  def hide
  end

  def unhide
  end

end
