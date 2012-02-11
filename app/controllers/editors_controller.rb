class EditorsController < ApplicationController

  def create
    section = Section.find(params[:section_id])
    current_user.editor_for(section) || (render_403 && return)
    user = User.find_by_email(params[:email])
    if !user
      flash.now.notice = "Cannot find user"
      redirect_to edit_section_path(section)
    else
      Editor.create(:section => section, :user => user)
      redirect_to edit_section_path(section)
    end
  end

  def destroy
    user = User.find(params[:user_id])
    section = Section.find(params[:section_id])
    current_user.editor_for(section) || (render_403 && return)
    Editor.find_by_user_id_and_section_id(user.id, section.id).destroy
    redirect_to edit_section_path(section)
  end

end
