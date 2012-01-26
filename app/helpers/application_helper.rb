module ApplicationHelper
  
  def canonical_article_path(article)
    s = article.section
    path = s.fullpath.map(&:name)[1..-1]
    path << article.id
    '/' + path.join('/').downcase.sub(/\s/, '')
  end

  def markdown(text)
    BlueCloth.new(text).to_html.html_safe
  end

  def ensure_utf8(text)
    # Converting ASCII-8BIT to UTF-8 based domain-specific guesses
    if text.is_a? String
      begin
        # Try it as UTF-8 directly
        cleaned = text.dup.force_encoding('UTF-8')
        unless cleaned.valid_encoding?
          # Some of it might be old Windows code page
          cleaned = text.encode( 'UTF-8', 'Windows-1252' )
        end
        text = cleaned
      rescue EncodingError
        # Force it to UTF-8, throwing out invalid bits
        text.encode!( 'UTF-8', invalid: :replace, undef: :replace )
      end
    end
    text
  end

  def number_to_picture(number)
    case number
    when 1
      'yone_small.png'
    when 2
      'ytwo_small.png'
    when 3
      'ythree_small.png'
    else
      'ylogo_thumb.png'
    end
  end
  
end
