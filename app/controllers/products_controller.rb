class ProductsController < ApplicationController
  before_action :authenticate_user!, only:[:destroy, :new, :edit]
  def new
    @product = Product.new
  end


  def index
    @products = Product.order(created_at: :desc)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to @product
    else
      flash[:alert] = "Problem creating your product"
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
  end

def product_params
  params.require(:product).permit(:title,:description,:price,:category_id)
end



def destroy
  @product = Product.find params[:id]
  if can? :destroy, @product
  @product.destroy
  flash[:notice] = "Product successfully deleted."
  redirect_to products_path
  else
  flash[:alert] = "Access Denied. You cannot delete a product that is not yours"
  redirect_to @product
  end
end


def edit
@product = Product.find params[:id]
# byebug
if user_signed_in? && can?(:edit, @product)
 @product = Product.find params[:id]
else
  redirect_to home_path
end
end

def update
  @product = Product.find params[:id]
  product_params = params.require(:product).permit(:title, :description ,:price, :category_id)
  # byebug
  if @product.update product_params
    redirect_to product_path(@product)
  else
    render :edit
  end
end


end
