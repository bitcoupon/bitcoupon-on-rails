# ApplicationController
class ApplicationController < ActionController::Base
  def bitcoin
    Bitcoupon::Api::BitcoinCall
  end

  private

  def check_headers
    if token.blank?
      render json: '{"error":"No token given"}', status: 401
      return
    elsif !token.eql?(Rails.application.secrets.api_secret)
      render json: '{"error":"Wrong token given"}', status: 401
    end
    response.headers['token'] = token
  end

  def token
    token = request.headers['token']
    token = params[:token] if token.nil? && params[:token]
    token
  end
end
