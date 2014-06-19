module Levelup
  module Endpoints
    # The class holding all functions related to orders that do not specify a
    # specific order. For single-order functions, see SpecificOrder.
    class Orders < Base
      # Creates an order. See OrderRequest for more info about the parameters.
      def create(order_request)
        request = build_request(order_request, Requests::CreateOrder)
        request.send_to_api(:post, endpoint_path)
      end

      private

      def path
        'orders'
      end
    end
  end
end
