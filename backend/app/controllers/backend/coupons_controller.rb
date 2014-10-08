module Backend
  # CouponsController
  class CouponsController < ApplicationController
    before_action :check_headers, only: [:create, :index, :show, :destroy]
    skip_before_filter :verify_authenticity_token, only: [:create, :destroy]

    def create
      coupon = Coupon.new(coupon_params)

      if coupon.save
        response.headers['id'] = coupon.id.to_s
        render json: coupon
      else
        render json: '{"error":"Invalid coupon"}'
      end
    end

    def destroy
      Coupon.find(params['id']).destroy

      render json: { head: :no_content }
    end

    def index
      render json: { pubkey: token, coupons: Coupon.all }
    end

    def show
      id = params[:id]
      @coupon = Coupon.find(id)

      render json: @coupon
    end

    private

    def check_headers
      render json: '{"error":"No token given"}' and return if token.blank?
      response.headers['token'] = token
    end

    def token
      token = request.headers['token']
      token = params[:token] if token.nil? && params[:token]
      token
    end

    def coupon_params
      params.require(:coupon).permit(:title, :description, :user_id)
    end
  end
end
