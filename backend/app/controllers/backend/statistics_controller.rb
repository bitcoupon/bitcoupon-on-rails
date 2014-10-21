module Backend
  # StatisticsController
  # Class for generating statistics from the transaction history
  #   that can be consumed by the admin client
  class StatisticsController < ApplicationController
    before_action :check_headers, only: [:total]

    def total
      binding.pry
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
end
