module Levelup
  module Requests
    # Represents a request to create an address for a specific user.
    # For information about its parameters, see UserAddressData and UserAuthenticated.
    # User access token must have the read_user_orders permission.
    class ListUserOrders < Base
      include Templates::UserAuthenticated

      def body
        {}
      end

      def response_from_hash(hash)
        orders = hash.map { |order| OpenStruct.new(order['order']) }
        Responses::Success.new(orders: orders)
      end
    end
  end
end
