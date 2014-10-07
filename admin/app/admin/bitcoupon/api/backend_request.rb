require_dependency 'bitcoupon/coupon_result'

module Admin
  module Bitcoupon
    module Api
      class BackendRequest
        attr_accessor :path, :api, :pubkey

        def initialize(path)
          @path = path
          @api = 'http://localhost:3002/backend'
          @pubkey = 'sdgkj32pidklj23lkjd'
        end

        # lol
        def start
          uri = URI.parse(api + path)
          request = Net::HTTP::Get.new(uri.path)

          request.add_field 'token', pubkey

          result = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(request)
          end

          result
        end
      end
    end
  end
end
