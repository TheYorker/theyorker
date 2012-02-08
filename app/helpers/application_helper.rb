module ApplicationHelper

  def canonical_article_path(article)
    s = article.section
    path = s.fullpath.map(&:name)[1..-1]
    path << article.id
    '/' + path.join('/').downcase.sub(/\s/, '')
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

  def render_safe_markdown(input)
    begin                       # we want to cope with crud in production
      unsafe_render(input).html_safe
    rescue Exception
      if Rails.env.production?
        return "Unable to render page"
      else
        raise
      end
    end
  end

  def render_unsafe_markdown(input)
    begin                       # we want to cope with crud in production
      sanitize(unsafe_render(input))
    rescue Exception
      if Rails.env.production?
        return "Unable to render page"
      else
        raise
      end
    end

  end

  def unsafe_render(input)
    expanded = expand_inline_erb(input)
    html = markdown(expanded)
    demote_headers(html, 2)
  end
  
  def expand_inline_erb(input)
    template = ERB.new(input)
    ensure_utf8(template.result(binding))
  end

  def markdown(input)
    ensure_utf8(BlueCloth.new(input).to_html)
  end

  def sanitize(input)
    
      config = Sanitize::Config::RELAXED
      youtube_transformer = lambda do |env|
        node      = env[:node]
        node_name = env[:node_name]

        # Don't continue if this node is already whitelisted or is not an element.
        return if env[:is_whitelisted] || !node.element?
        
        # Don't continue unless the node is an iframe.
        return unless node_name == 'iframe'
        
        # Verify that the video URL is actually a valid YouTube video URL.
        return unless node['src'] =~ /\Ahttps?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\//
        
        # We're now certain that this is a YouTube embed, but we still need to run
        # it through a special Sanitize step to ensure that no unwanted elements or
        # attributes that don't belong in a YouTube embed can sneak in.
        Sanitize.clean_node!(node, {
                               :elements => %w[iframe],
                               
                               :attributes => {
                                 'iframe'  => %w[allowfullscreen frameborder height src width]
                               }
                             })
        
        # Now that we're sure that this is a valid YouTube embed and that there are
        # no unwanted elements or attributes hidden inside it, we can tell Sanitize
        # to whitelist the current node.
        {:node_whitelist => [node]}
      end

      config[:transformers] = [youtube_transformer]
      config[:elements] += ['div']
      config[:attributes][:all] += ['class']
      config[:attributes]['div'] = ['style']

      Sanitize.clean(input, config).html_safe
  end

  def demote_headers(input, level)
    result = input.gsub(/<(\/?)h([0-7])>/) {"<#$1h#{$2.to_i+level}>"}
  end

end
