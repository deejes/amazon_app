class Product < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :category
  belongs_to :user
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :favoriters ,through: :favorites, source: :user

  def review_list()
    self.reviews.order(created_at: :desc)

  end


  validates :title, uniqueness: true
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :title, presence: true
  validates :title, length: { minimum: 10 }

  def tag_list
    #tags.map {|tag| tag.name}
    tags.map(&:name).join(', ')
  end

  def tag_list=(value)
    self.tags = value.split(/\s*,\s*/).map do |name|
      Tag.where(name: name.downcase).first_or_create!
    end
  end


end
