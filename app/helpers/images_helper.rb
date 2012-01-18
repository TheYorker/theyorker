module ImagesHelper
  
  def image_with_caption(id, caption, size=:medium)
    image = Image.find(id)
    width = image.picture.width(size)
    embed = ERB.new <<EOF
<div class="main_image" width="<%= width %>"><img src="<%= image.picture.url(size) %>" / ><div class="image_caption" style="max-width:<%= image.picture.width(size) %>px;"><%= caption %> &copy; <%= image.copyright_owner %> <%= image.image_credit != "" ? "Image Credit: #{image.image_credit}" : "" %></div></div>
EOF
    embed.result(binding)
  end


end
