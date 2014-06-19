module Levelup
  module Endpoints
    # The endpoint holding all functions related to orders for a specified user.
    class UserOrders < Base
      def list(user_access_token)
        request = Requests::ListUserOrders.
          new(user_access_token: user_access_token)
        request.send_to_api(:get, endpoint_path)
      end

      private

      def path
        'users/orders'
      end
    end
  end
end
