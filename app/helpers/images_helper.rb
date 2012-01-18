module ImagesHelper
  
  def image_with_caption(id, caption, size=:medium)
    image = Image.find(id)
    embed = ERB.new <<EOF
<div class="main_image"><img src="<%= image.picture.url(size) %>" / ><div class="image_caption"><%= caption %> &copy; <%= image.copyright_owner %> <%= image.image_credit != "" ? "Image Credit: #{image.image_credit}" : "" %></div></div>
EOF
    embed.result(binding)
  end


end
