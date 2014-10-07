require_dependency 'bitcoupon/coupon_result'

module Admin
  module Bitcoupon
    module Api
      class BackendRequest
        attr_accessor :path, :api, :pubkey, :method

        def initialize(http_method, path)
          @method = http_method
          @path = path
          @api = 'http://localhost:3002/backend'
          @pubkey = 'sdgkj32pidklj23lkjd'
        end

        def start
          uri = URI.parse(api + path)
          request = http_class.new(uri.path)

          request.add_field 'token', pubkey

          result = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(request)
          end

          result
        end

        def http_class
          methods = {
            get: Net::HTTP::Get
          }
          methods[method]
        end
      end
    end
  end
end
