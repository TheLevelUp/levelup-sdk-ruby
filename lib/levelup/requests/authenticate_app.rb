module Levelup
  module Requests
    # Represents a request to generate an app access token.
    class AuthenticateApp < Base
      # The API key assigned to your app
      attr_accessor :api_key
      # The secret code assigned to your app
      attr_accessor :client_secret

      def auth_type
        :none
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['access_token'])
      end
    end
  end
end
