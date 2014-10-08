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
end
