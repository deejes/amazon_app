# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'Faker'
require 'faker'


Product.destroy_all
Category.destroy_all

categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']

categories.each do |category|
  Category.create(name: category)
end
# 
# 1000.times do
#   category = Category.all.sample
#
#   p = Product.create(
#     title: Faker::Superhero.name,
#     description: Faker::Hipster.sentence,
#     price: Faker::Commerce.price,
#     category_id: category.id
#   )
# end
#
# puts "#{Product.count} products created!"
