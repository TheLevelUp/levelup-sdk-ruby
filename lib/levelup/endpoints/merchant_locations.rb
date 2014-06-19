module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a single merchant's
    # locations. This is a v14 endpoint and should not be expected to remain
    # functional indefinitely.
    class MerchantLocations < Base
      def initialize(merchant_id)
        @id = merchant_id
      end

      # Provides a list of locations controlled by this merchant. This list is
      # not paginated.
      #
      # [merchant_auth_token]
      #   An authorization token with permission to view
      #   this merchant.
      def list(merchant_auth_token)
        request = Requests::ListLocations.new(
          merchant_access_token: merchant_auth_token)
        request.send_to_api(:get, endpoint_path(:v14))
      end

      private

      attr_reader :id

      def path
        "merchants/#{id}/locations"
      end
    end
  end
end
