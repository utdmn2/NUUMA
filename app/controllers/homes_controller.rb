class HomesController < ApplicationController
  def top
    @posts = Post.all
  end

  def guideline; end

  def privacy; end

  def post_rule; end
end
