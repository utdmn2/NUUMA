class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations

  #いいね機能
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  #検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  #投稿一覧ソート機能
  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return all.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end
  end

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :category_ids, presence: true

  attachment :image
end
