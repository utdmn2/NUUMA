class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_user_path(post.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, category_ids: [])
  end
end
