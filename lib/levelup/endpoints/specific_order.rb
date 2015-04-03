module Levelup
  module Endpoints
    # Endpoint holding all functions relating to a specified order.
    class SpecificOrder < Base
      def initialize(order_uuid)
        self.uuid = order_uuid
      end

      # Refunds the order specified by this endpoint.
      # @param merchant_access_token [string] An access token for a user that manages this location.
      def refund(merchant_access_token)
        Requests::RefundOrder.new(merchant_access_token: merchant_access_token).
          send_to_api(:post, endpoint_path + '/refund')
      end

      private

      attr_accessor :uuid

      def path
        "orders/#{uuid}"
      end
    end
  end
end
