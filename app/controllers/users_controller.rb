class UsersController < ApplicationController

  layout :member_layout

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signup successful!"
    else
      render "login"
    end
  end

  def login
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def dashboard
    
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
