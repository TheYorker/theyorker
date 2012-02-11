class UsersController < ApplicationController

  before_filter :admin_access, :except => ['create', 'show', 'update', 'login', 'articles', 'sections', 'edit']
  before_filter :find_user, :except => ['create', 'login', 'index', 'email_search']
  before_filter :self_only, :except => ['create', 'login', 'index', 'email_search', 'suspend']

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

  def update
    if @user.update_attributes(params[:user])
      flash.notice = "Update succeeded"
    else
      flash.notice = "Update failed"
    end
    redirect_to user_path(@user)
  end

  def login
    @user = User.new
  end

  def show
    if current_user != @user
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
    @draft_articles = @user.draft_articles.paginate :page => params[:draft_page], :per_page => 10
    @review_articles = @user.review_articles.paginate :page => params[:review_page], :per_page => 10
    @published_articles = @user.published_articles.paginate :page => params[:published_page], :per_page => 10
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

  def email_search
    user = User.find_by_email(params[:email])
    @userdata = { id: user.id, email: user.email, name: user.name} 
    render :json => @userdata
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

  def self_only
    return (current_user == @user) || render_403
  end

end
