module Backend
  # AddressesController
  class AddressesController < ApplicationController
    before_action :check_headers, only: [:address, :word]

    skip_before_filter :verify_authenticity_token, only: [:address, :word]

    def address
      address = Address.where(address: params[:address].chomp)
      if address.any?
        render json: { word: address.first.word.word }.to_json
      else
        address = Address.create(address: params[:address].chomp)
        address.word = Word.find(address.id)
        address.save
        render json: { word: address.word.word.chomp }.to_json
      end
    end

    def word
      word = Word.where(word: params[:word].chomp).first
      address = Address.where(word_id: word.id)

      if address.any?
        render json: { address: address.address.chomp }
      else
        render json: { error: 'word not found' }, status: 404
      end
    end
  end
end
