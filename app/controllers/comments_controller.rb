class CommentsController < ApplicationController

  before_filter :admin_access, :only => ['hide', 'unhide']

  def create
    if !current_user
      flash.now.error = "Must be logged in to post comments"
      redirect_to article_path(article)
      return
    end
    article = Article.find(params[:id])
    anon = params[:comment][:anonymous] == "true"
    comment = article.comments.create(:user => current_user,
                                      :anonymous => anon,
                                      :body => params[:comment][:body])
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
