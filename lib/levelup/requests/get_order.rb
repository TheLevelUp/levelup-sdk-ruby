module Levelup
  module Requests
    # Represents a request to access information about a
    # specific order under a merchant.
    class GetOrder < Base
      include Templates::MerchantAuthenticated

      def auth_type
        :merchant_v14
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['order'])
      end
    end
  end
end
