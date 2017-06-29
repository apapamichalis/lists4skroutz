class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user
      if @user == current_user
        return
      else
        redirect_to user_lists_path(@user)
      end
    else
      redirect_to new_user_session_path, :alert => "Access denied."  
    end
  end

end
