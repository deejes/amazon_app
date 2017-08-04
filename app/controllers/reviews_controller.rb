class ReviewsController < ApplicationController
  def review_params
    params.require(:review).permit(:body,:rating)
  end

  def create

    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review['product_id'] = params[:product_id]
    @review['user_id'] = current_user.id

    # byebug
    if @review.save
      redirect_to @product, notice: "review successfully created"
      puts "that worked!"
    else
      render '/products/show' , alert: 'rview not created'
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
      redirect_to product_path(params[:product_id]), notice: 'Review Deleted!'
    else
      redirect_to product_path(params[:product_id]), alert: 'Review NOT Deleted!'
    end
  end

end
