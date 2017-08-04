class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:create]
  before_action :find_favorite, only: [:destroy]

def create
  favorite = Favorite.new user: current_user, product: @product
  if favorite.save
    redirect_to products_path, notice: 'Thanks for liking!'
  else
    redirect_to @product, alert: favorite.errors.full_messages.join(', ')
  end
end

def destroy
  if @favorite.destroy
    redirect_to product_path, notice: ':('
  else
    redirect_to product_path, alert: ':('
  end
end

  private

  def find_product
    # byebug
    @product = Product.find(params[:product_id])
  end

  def find_favorite
    @favorite = Favorite.find(params[:id])
  end

end
