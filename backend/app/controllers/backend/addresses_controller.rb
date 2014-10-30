module Backend
  # AddressesController
  class AddressesController < ApplicationController
    before_action :check_headers, only: [:address]

    skip_before_filter :verify_authenticity_token, only: [:address]

    def address
      address = Address.where(address: params[:address])

      if address.any?
        render json: { word: address.first.word.word }.to_json
      else
        address = Address.create(address: params[:address])
        address.word = Word.find(address.id)
        address.save
        render json: { word: address.word.word }.to_json
      end
    end
  end
end
