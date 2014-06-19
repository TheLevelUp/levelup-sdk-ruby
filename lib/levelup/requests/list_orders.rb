module Levelup
  module Requests
    # Represents a request to list all orders made at a
    # specified location. This is a v14 request and should not be expected to
    # remain functional indefinitely.
    class ListOrders < Base
      include Templates::MerchantAuthenticated

      def auth_type
        :merchant_v14
      end

      def response_from_hash(hash)
        if hash.nil? # no orders found for this location
          Responses::Success.new(orders: [])
        else
          orders = hash.map { |order| OpenStruct.new(order['order']) }
          Responses::Success.new(orders: orders)
        end
      end
    end
  end
end
