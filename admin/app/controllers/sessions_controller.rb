# SessionsController
class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Welcome to Bitcoupon Admin'

      redirect_to user_path(user)
    else
      redirect_to root_path(alert: 'Wrong password')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'You have been logged out'
  end
end
