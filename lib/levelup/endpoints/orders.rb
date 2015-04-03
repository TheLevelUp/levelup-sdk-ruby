module Levelup
  module Endpoints
    # The class holding all functions related to orders that do not specify a
    # specific order. For single-order functions, see SpecificOrder.
    class Orders < Base
      # Creates an order. See Requests::CreateOrder for more info about the parameters.
      def create(order_request)
        build_request(order_request, Requests::CreateOrder).
          send_to_api(:post, endpoint_path)
      end

      private

      def path
        'orders'
      end
    end
  end
end
