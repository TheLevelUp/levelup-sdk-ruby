module Levelup
  module Templates
    # A template to apply to any requests requiring v15 merchant authentication.
    # If your request requires v14 merchant authentication, include this module
    # and define auth_type as :merchant_v14.
    # Authentication template - only apply one authentication template per request.
    module MerchantAuthenticated
      # An access token for a merchant that has granted you 'manage_merchant_orders' permissions.
      attr_accessor :merchant_access_token

      def auth_type
        :merchant
      end
    end
  end
end
