class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, category_ids: [])
  end
end
