module Levelup
  module Requests
    # Represents a request to generate a merchant access token.
    class AuthenticateMerchant < Base
      # Your merchant's API key (accepts app API key as well)
      attr_accessor :api_key
      # The username used to log into your merchant account
      attr_accessor :username
      # Your merchant account's password
      attr_accessor :password

      def auth_type
        :none
      end

      def body
        { access_token: to_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['access_token'])
      end
    end
  end
end
