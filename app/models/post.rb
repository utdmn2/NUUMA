class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search,word)
    if search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      @post = Post.where("#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }


  attachment :image

end
