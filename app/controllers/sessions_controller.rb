class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "thank you for signing in"
    else
      flash.now[:alert] = 'wrong email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "You are logged out"
  end

end
