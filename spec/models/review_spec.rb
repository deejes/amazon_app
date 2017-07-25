require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'one product with many reviews' do
    it 'should be able to have 2 reviews' do
    user = FactoryGirl.create(:user)
    product = FactoryGirl.create(:product)
    before_count = Review.count
    r = Review.create(body:'this is dummy text for a review', rating:3,product: Product.last, user: User.last)
    r1 = Review.create(body:'this is dummy text for a reviedsfw', rating:3,product: Product.last, user: User.last)
    expect(Review.count).to eq(before_count+2)
    # byebug
    end

  end

end
