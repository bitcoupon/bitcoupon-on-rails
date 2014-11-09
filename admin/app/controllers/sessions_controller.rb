# SessionsController
class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Welcome to Bitcoupon Merchant'

      redirect_to root_path
    else
      redirect_to welcome_path, alert: 'Wrong password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_path, notice: 'You have been logged out'
  end
end
