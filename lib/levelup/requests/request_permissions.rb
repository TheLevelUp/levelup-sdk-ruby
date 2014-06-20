module Levelup
  module Requests
    # Represents a request to request a set of permissions
    # from a specified account (merchant or user).
    class RequestPermissions < Base
      include Templates::AppAuthenticated
      # The email address of the requested user or merchant.
      attr_accessor :email
      # An array of strings representing desired permissions from the user or
      # merchant. Common permissions include 'create_orders' and
      # 'manage_merchant_orders'
      attr_accessor :permission_keynames

      def body
        { permissions_request: to_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['permissions_request'])
      end
    end
  end
end
