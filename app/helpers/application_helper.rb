module ApplicationHelper
  def pad_top
    image_urls = [home_path, root_path, login_path, new_user_path]
    image_urls.each { |url| return false if request.fullpath == url }
    return true
  end
end
