module Levelup
  module Endpoints
    # The endpoint serving as a bucket for all user-related functions.
    class Users < Base
      def get(user_access_token)
        Requests::GetUser.new(user_access_token: user_access_token).
          send_to_api(:get, endpoint_path)
      end

      def orders
        UserOrders.new
      end

      private

      def path
        'users'
      end
    end
  end
end
