module Levelup
  module Requests
    # Represents a request to refund a specified order.
    # Merchant access token must have the manage_merchant_orders permission.
    class RefundOrder < Base
      include Templates::MerchantAuthenticated

      # If your merchant account is configured to require one, a confirmation
      # code permitting this refund.
      attr_accessor :manager_confirmation

      def body
        { refund: to_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['order'])
      end
    end
  end
end
