class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.reverse_order
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を更新しました！"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @current_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction, :birth_date, :is_deleted, :agreement)
    end
end
