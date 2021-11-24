class User::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    # @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    @categories = Category.all
    @posts = params[:name].present? ? Category.find(params[:name]).posts : Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '記事を投稿しました！'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path if @post.user != current_user
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '記事を更新しました！'
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(post.user_id)
  end

  def sort
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, category_ids: [])
  end
end
