class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    # tag_params = params.require(:tag).permit(:id)
    @tag = Tag.find_by(id: params[:id])
    @products = @tag.products

  end


end
  
