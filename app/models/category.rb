class Category < ApplicationRecord
  has_many :post_category_relations, dependent: :destroy
  has_many :posts, through: :post_category_relations
end
