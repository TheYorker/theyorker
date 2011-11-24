class MembershipListsController < ApplicationController

  def create
    @membership_list = MembershipList.new(params[:membership_list])
    if @membership_list.save
      redirect_to membership_list_path(@membership_list), :notice => "Membership List created successfully"
    else
      render "new"
    end
  end

  def show
    redirect_to edit_membership_list_path(@membership_list)
  end

  def edit
    @membership_list = MembershipList.find(params[:id])
  end

  def update
    @membership_list = MembershipList.find(params[:id])
    if @membership_list.update_attributes(params[:membership_list])
      flash.now.notice = "Membership List saved successfully"
      redirect_to membership_list_path(@membership_list)
    else
      flash.now.alert = "Unable to save membership list"
      render "edit"
    end
  end

  def new
    @membership_list = MembershipList.new
  end

end
