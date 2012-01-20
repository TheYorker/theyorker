module Paperclip
  class Padder < Thumbnail
    def transformation_command
      if geometry_extent == '800x500'
        super + ["-gravity center",
                 "-background white",
                 "-extent", %["#{geometry_extent}"]]
      else
        super
      end
    end

    def geometry_extent
      "#{target_geometry.width.to_i}x#{target_geometry.height.to_i}"
    end
  end
end
