module Levelup
  module Endpoints
    # The endpoint holding all functions relating to orders for a specific
    # location.
    # This is a v14 endpoint and should not be expected to remain functional
    # indefinitely.
    class LocationOrders < Base
      def initialize(location_id)
        @id = location_id
      end

      # Gets a list of orders made at this location. This list is paginated.
      #
      # [merchant_auth_token]
      #   An access token for the merchant that owns this
      #   location.
      def list(merchant_auth_token)
        request = Requests::ListOrders.new(
          merchant_access_token: merchant_auth_token)
        request.send_to_api(:get, endpoint_path(:v14))
      end

      private

      attr_reader :id

      def path
        "locations/#{id}/orders"
      end
    end
  end
end
