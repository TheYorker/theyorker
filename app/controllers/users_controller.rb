class UsersController < ApplicationController

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

  def dashboard

  end

end
