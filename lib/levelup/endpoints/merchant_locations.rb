module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a single merchant's locations. This is a v14
    # endpoint and should not be expected to remain functional indefinitely.
    class MerchantLocations < Base
      def initialize(merchant_id)
        @id = merchant_id
      end

      # Provides a list of locations controlled by this merchant. This list is not paginated.
      #
      # @param merchant_access_token [string] An access token for a user that manages this location.
      def list(merchant_access_token)
        Requests::ListLocations.new(merchant_access_token: merchant_access_token).
          send_to_api(:get, endpoint_path(:v14))
      end

      private

      attr_accessor :id

      def path
        "merchants/#{id}/locations"
      end
    end
  end
end
