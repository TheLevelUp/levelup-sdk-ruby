module Levelup
  module Endpoints
    # The endpoint holding all functions relating to orders for a specific location.
    # This is a v14 endpoint and should not be expected to remain functional indefinitely.
    class LocationOrders < Base
      def initialize(location_id)
        self.id = location_id
      end

      # Gets a list of orders made at this location. This list is paginated.
      # @param merchant_access_token [string] An access token for a user that manages this location.
      def list(merchant_access_token)
        Requests::ListOrders.new(merchant_access_token: merchant_access_token).
          send_to_api(:get, endpoint_path(:v14))
      end

      private

      attr_accessor :id

      def path
        "locations/#{id}/orders"
      end
    end
  end
end
