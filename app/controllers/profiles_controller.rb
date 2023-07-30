class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all
  end
  def show
    @user =
      if params[:id]== "me"
        if current_user
          current_user
        else
          flash[:success] = "You are not authorized to view this page"
          redirect_to new_user_session_path
        end
      else
        User.find(params[:id])
      end
  end
end
