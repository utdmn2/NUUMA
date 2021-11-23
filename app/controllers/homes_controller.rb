class HomesController < ApplicationController
  def top
    @posts = Post.all
  end

  def guideline; end

  def privacy; end

  def post_rule; end


  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.agreement_terms = true
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
