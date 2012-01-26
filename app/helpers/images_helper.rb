module ImagesHelper
  
  def image_with_caption(id, caption, size=:medium)
    image = Image.find(id)
    width = "#{image.picture.width(size)}".encode('UTF-8')
    credit = "#{image.image_credit}".encode('UTF-8')
    
    embed = ERB.new <<EOF
<div <%= size == :medium ? 'class="main_image"' : 'class="image_container"' %>><img src="<%= image.picture.url(size) %>" / ><div class="image_caption" style="max-width:#{width}px;"><%= caption %> &copy;<%= image.copyright_owner %><%= image.image_credit != "" ? "; Image Credit: #{image.image_credit}" : "" %></div></div>
EOF
    embed.result(binding).encode('UTF-8')
  end


end
