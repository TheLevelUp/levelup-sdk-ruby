module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a single merchant's orders.
    # This is a v14 endpoint and should not be expected to remain functional indefinitely.
    class MerchantOrders < Base
      def initialize(merchant_id)
        self.id = merchant_id
      end

      # Provides merchant-facing details about a specific order. For more
      # information about the parameters, @see Requests::CreateOrderDetails.
      def details(uuid, merchant_access_token)
        Requests::CreateOrderDetails.new(merchant_access_token: merchant_access_token).
          send_to_api(:get, endpoint_path(:v14) + "/#{uuid}")
      end

      private

      attr_accessor :id

      def path
        "merchants/#{id}/orders"
      end
    end
  end
end
