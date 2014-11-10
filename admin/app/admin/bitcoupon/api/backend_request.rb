module Bitcoupon
  module Api
    # BackendRequest: This class handles API requests to backend
    class BackendRequest
      attr_accessor :path, :api, :api_secret, :method, :content_type, :body

      def initialize(http_method, path)
        @method = http_method
        @path = path
        @api = 'http://localhost:3002/backend'
        @api_secret = Rails.application.secrets.api_secret
      end

      def start
        uri = URI.parse(api + path)
        request = http_class.new(uri.path)

        request.add_field 'token', api_secret
        add_post_parameters(request) if body

        result = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(request)
        end

        token = result.header['token']

        token.eql?(api_secret) ? result : nil
      end

      private

      def http_class
        methods = {
          get: Net::HTTP::Get,
          post: Net::HTTP::Post,
          delete: Net::HTTP::Delete
        }
        methods[method]
      end

      def add_post_parameters(request)
        request.content_type = content_type
        request.body = body
      end
    end
  end
end
