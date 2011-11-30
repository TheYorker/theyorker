module CommentsHelper
  
  def article_comments_path(article)
    "/articles/#{article.id}/comments"
  end
  
end
