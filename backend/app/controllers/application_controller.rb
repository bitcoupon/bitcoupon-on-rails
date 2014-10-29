# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def bitcoin
    Bitcoupon::Api::BitcoinCall
  end

  private

  def check_headers
    if token.blank?
      render json: '{"error":"No token given"}'
      return
    end
    response.headers['token'] = token
  end

  def token
    token = request.headers['token']
    token = params[:token] if token.nil? && params[:token]
    token
  end
end
