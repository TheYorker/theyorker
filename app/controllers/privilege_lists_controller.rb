class PrivilegeListsController < ApplicationController

  before_filter :admin_access

  def create
    @privilege_list = PrivilegeList.new(params[:privilege_list])
    if @privilege_list.save
      redirect_to privilege_list_path(@privilege_list), :notice => "Privilege List created successfully"
    else
      render "new"
    end
  end

  def show
    redirect_to edit_privilege_list_path(@privilege_list)
  end

  def edit
    @privilege_list = PrivilegeList.find(params[:id])
  end

  def update
    @privilege_list = PrivilegeList.find(params[:id])
    if @privilege_list.update_attributes(params[:privilege_list])
      flash.now.notice = "Privilege List saved successfully"
      redirect_to privilege_list_path(@privilege_list)
    else
      flash.now.alert = "Unable to save privilege list"
      render "edit"
    end
  end

  def new
    @privilege_list = PrivilegeList.new
  end

end
