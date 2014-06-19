module Levelup
  module Endpoints
    # Endpoint holding all functions relating to a specified order.
    class SpecificOrder < Base
      def initialize(order_uuid)
        self.uuid = order_uuid
      end

      # Refunds the order specified by this endpoint.
      #
      # [merchant_auth_token]
      #   A merchant access token with permissions to
      #   refund orders made at the location where this order was placed.
      def refund(merchant_auth_token)
        request = Requests::RefundOrder.new(
          merchant_access_token: merchant_auth_token)
        request.send_to_api(:post, endpoint_path + '/refund')
      end

      private

      attr_accessor :uuid

      def path
        "orders/#{uuid}"
      end
    end
  end
end
