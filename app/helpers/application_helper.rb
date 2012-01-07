module ApplicationHelper

  def markdown(text)
    BlueCloth.new(text).to_html.html_safe
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
