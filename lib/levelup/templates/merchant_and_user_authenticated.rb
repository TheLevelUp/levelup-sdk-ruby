module Levelup
  module Templates
    # A template to apply to any requests requiring both merchant and user authentication.
    # Authentication template - only apply one authentication template per request.
    module MerchantAndUserAuthenticated
      # An access token for a merchant that has granted you 'manage_merchant_orders' permissions.
      attr_accessor :merchant_access_token
      # An access token for a user that has granted you 'create_orders' permissions.
      attr_accessor :user_access_token

      def auth_type
        :merchant_and_user
      end
    end
  end
end
