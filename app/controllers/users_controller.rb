class UsersController < ApplicationController

  before_filter :admin_access, :only => ['admin', 'suspend', 'unsuspend']
  before_filter :find_user, :except => ['create', 'login', 'index']

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
    if current_user && current_user != @user
      render :layout => "application"
      return true
    end
  end

  def edit
  end

  def index
    @users = User.all
  end

  def dashboard
    
  end

  def sections
    @sections = Section.toplevels(@user.sections)
  end

  def articles
  end

  def admin
  end

  def suspend
    @user.suspend
    redirect_to user_path(@user)
  end

  def unsuspend
    @user.unsuspend
    redirect_to user_path(@user)
  end

  private
  
  def member_layout
    if current_user && current_user.member?
      "member"
    else
      "application"
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

end
