module Levelup
  module Requests
    # Represents a request to grant merchant-funded credit to a user.
    # Merchant access token must have the give_merchant_funded_credit
    # permission.
    class GiveMerchantCredit < Base
      include Templates::MerchantAuthenticated
      attr_accessor :email, :value_amount

      def body
        { merchant_funded_credit: to_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new
      end
    end
  end
end
