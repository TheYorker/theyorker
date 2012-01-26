module ArticlesHelper

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

  def render_sanitized_markdown(input)
    # this is horrible
    # it needs the following refactorings:
    # - saner approach to encoding than sprinkling `.encode('UTF-8')` everywhere
    # - better approach to sanitization

    begin
      if !input
        return ""
      end

      input = ensure_utf8(input)

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

      template = ERB.new(input)
      expanded = ensure_utf8(template.result(binding))

      html = Sanitize.clean(BlueCloth.new(expanded).to_html, config)
      # increase heading levels of markdown output by 2
      result = html.gsub(/<(\/?)h([0-7])>/) {"<#$1h#{$2.to_i+2}>"}.html_safe
      ensure_utf8(result)
    rescue
      "Unable to render page"
    end

  end

  
end
