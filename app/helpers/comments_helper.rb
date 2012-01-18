module CommentsHelper
  
  def article_comments_path(article)
    "/articles/#{article.id}/comments"
  end

  def comment_user(comment)
    if comment.anonymous?
      "Anonymous"
    else
      link_to comment.user.name, user_path(comment.user)
    end
  end

  def anonymous_comment_user(comment)
    if is_admin? && comment.anonymous
      link_to "[#{comment.user.name}]", user_path(comment.user)
    else
      ""
    end
  end

end
