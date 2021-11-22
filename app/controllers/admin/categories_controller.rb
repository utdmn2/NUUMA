class Admin::CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to admin_categories_path
  end

  def index
    @category = Category.new
    @categories = Category.page(params[:page]).per(10)
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.permit(:name)
  end
end
