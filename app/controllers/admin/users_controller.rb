class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "ステータス変更ずみ"
    redirect_to "/admin/users"
  end

  private
  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
