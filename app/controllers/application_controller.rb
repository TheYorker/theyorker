class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def member_access
    (current_user && current_user.member?) || render_403
  end
  
  def admin_access
    return (current_user && current_user.admin?) || render_403
  end

  def render_403
    render :file => "#{Rails.root}/public/403.html", :layout => false
  end

end
