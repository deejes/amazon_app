class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers ,through: :likes, source: :user
end
