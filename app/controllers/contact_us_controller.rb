class ContactUsController < ApplicationController
  def index
  end
  def thanks
  end
  def create
  @name = params[:name]
  render 'thanks'
  end
end
