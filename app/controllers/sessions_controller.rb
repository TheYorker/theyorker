class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.suspended
      render :file => "#{Rails.root}/public/suspended.html", :layout => false
      return
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.update_attributes(:member => PrivilegeList.member?(user.email))
      user.update_attributes(:admin => PrivilegeList.admin?(user.email))
      redirect_to user_path(user), :notice => "#{user.name} logged in successfully"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to login_path, :alert => "Invalid email address or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end

end
