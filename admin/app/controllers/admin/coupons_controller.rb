require_dependency '../bitcoupon/api/backend_request'
require_dependency '../bitcoupon/api/bitcoin_call'
require 'shellwords'

module Admin
  class CouponsController < ApplicationController
    def index
      request = backend_request.new :get, '/coupons'
      result = request.start

      body = JSON.parse(result.body)

      @coupons = body['coupons']
    end

    def show
      id = params[:id]

      request = backend_request.new :get, '/coupon/' + id
      result = request.start

      @coupon = JSON.parse(result.body)
    end

    def new
      @coupon = Coupon.new
    end

    def create
      request = backend_request.new :post, '/coupons'
      request.content_type = 'application/json'
      request.body = { coupon: coupon_params }.to_json
      result = request.start

      id = result.header['id'].to_i
      redirect_to admin_coupon_path(id)
    end

    def destroy
      id = params['id']
      request = backend_request.new :delete, '/coupon/' + id
      request.start

      redirect_to admin_coupons_path
    end

    private

    def coupon_params
      params.require(:coupon).permit(:title, :description)
    end
  end
end
