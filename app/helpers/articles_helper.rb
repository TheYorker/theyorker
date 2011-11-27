module ArticlesHelper

  def visibility_as_text(visibility)
    case visibility
    when 1
      'Private'
    when 2
      'Editorial Review'
    when 3
      'Public'
    else
      "Don't understand this visibility! Please file a bug report"
    end
  end
  
end
