class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews

  def review_list()
    self.reviews.order(created_at: :desc)

  end


  validates :title, uniqueness: true
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :title, presence: true
  validates :title, length: { minimum: 10 }


end
