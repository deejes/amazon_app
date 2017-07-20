class Admin::DashboardController < Admin::BaseController
  def index
    @products = Product.all
    @users = User.all


  end

end
