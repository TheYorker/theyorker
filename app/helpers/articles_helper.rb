module ArticlesHelper

  def canonical_article_path(article)
    s = article.section
    path = s.fullpath.map(&:name)[1..-1]
    path << article.id
    '/' + path.join('/').downcase.sub(/\s/, '')
  end

  def visibility_as_text(visibility)
    case visibility
    when 1
      'Draft'
    when 2
      'Editorial Review'
    when 3
      'Public'
    else
      "Don't understand this visibility! Please file a bug report"
    end
  end
  
end
