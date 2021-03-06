module Levelup
  module Endpoints
    # The endpoint holding all functions related to the management of access tokens.
    class AccessTokens < Base
      # The API key assigned to your app. Preconfigured key.
      attr_writer :api_key
      # The client secret assigned to your app. Preconfigured key.
      attr_writer :secret

      def initialize(auth_info)
        @api_key = auth_info[:api_key]
        @secret = auth_info[:secret]
      end

      # Generates a new app access token. If passed no parameters, attempts to
      # pass the preconfigured API key and client secret to the endpoint.
      def create_for_app(app_auth_request = nil)
        build_request(app_auth_request || { api_key: @api_key, client_secret: @secret },
            Requests::AuthenticateApp).
          send_to_api(:post, endpoint_path)
      end

      # Generates a new merchant access token.
      def create_for_merchant(merchant_auth_request)
        build_request(merchant_auth_request,
            Requests::AuthenticateMerchant).
          send_to_api(:post, endpoint_path(:v14))
      end

      private

      def path
        'access_tokens'
      end
    end
  end
end
