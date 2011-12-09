class UsersController < ApplicationController

  before_filter :admin_access, :only => ['admin']

  layout :member_layout

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.update_attributes(:member => PrivilegeList.member?(@user.email))
      redirect_to user_path(@user), :notice => "Signup successful!"
    else
      render "login"
    end
  end

  def login
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if current_user && current_user != @user
      render :layout => "application"
      return true
    end
  end

  def index
    @users = User.all
  end

  def dashboard
    
  end

  def sections
    @user = User.find(params[:id])
    @sections = Section.toplevels(@user.sections)
  end

  def articles
    @user = User.find(params[:id])
  end

  def admin
    @user = User.find(params[:id])
  end

  private
  
  def member_layout
    if current_user && current_user.member?
      "member"
    else
      "application"
    end
  end

end
