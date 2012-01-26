module ImagesHelper
  
  def image_with_caption(id, caption, size=:medium)
    image = Image.find(id)
    width = ensure_utf8("#{image.picture.width(size)}")
    credit = ensure_utf8("#{image.image_credit}")
    
    template = <<EOF
<div <%= size == :medium ? 'class="main_image"' : 'class="image_container"' %>><img src="<%= image.picture.url(size) %>" / ><div class="image_caption" style="max-width:#{width}px;"><%= caption %> &copy;<%= image.copyright_owner %><%= image.image_credit != "" ? "; Image Credit: #{credit}" : "" %></div></div>
EOF

    template = ensure_utf8(template)

    embed = ERB.new(template)

    ensure_utf8(embed.result(binding))
  end


end
