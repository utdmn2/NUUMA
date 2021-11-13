class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #新規登録チェックボックスvalidation
  validates :agreement_terms, allow_nil: false, acceptance: true, on: :create
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  attachment :profile_image

end
