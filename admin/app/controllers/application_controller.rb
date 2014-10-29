# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def backend_request
    Bitcoupon::Api::BackendRequest
  end

  def bitcoin
    Bitcoupon::Api::BitcoinCall
  end

  def create_address
    if current_user
      current_user.create_address.chomp
    else
      '138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6'
    end
  end

  def return_address
    if current_user
      current_user.return_address.chomp
    else
      '138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6'
    end
  end

  def create_private_key
    if current_user
      current_user.create_private_key.chomp
    else
      '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    end
  end

  def return_private_key
    if current_user
      current_user.return_private_key.chomp
    else
      '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    end
  end

  private

  def require_signin!
    return if current_user
    redirect_to(root_path,
                alert: 'You have to be logged in to access this page.')
  end

  helper_method :require_signin!

  def current_user
    session[:user_id] = nil if User.where(id: session[:user_id]).empty?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
