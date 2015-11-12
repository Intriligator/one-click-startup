module ApplicationHelper
  def render_image
    image_urls = [home_path, root_path]
    image_urls.each { |url| return true if request.fullpath == url }
    return false
  end
end
