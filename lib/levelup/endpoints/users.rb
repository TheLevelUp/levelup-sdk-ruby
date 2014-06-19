module Levelup
  module Endpoints
    # The endpoint serving as a bucket for all user-related functions.
    class Users < Base
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
