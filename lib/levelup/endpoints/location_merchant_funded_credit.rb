module Levelup
  module Endpoints
    # The endpoint holding all functions relating to managing merchant-funded credit.
    class LocationMerchantFundedCredit < Base
      def initialize(location_id)
        @id = location_id
      end

      def get(payment_token_data, merchant_access_token)
        @payment_token_data = payment_token_data
        Requests::GetLocationMerchantFundedCredit.new(
            merchant_access_token: merchant_access_token).
          send_to_api :get, endpoint_path
      end

      private

      def path
        "locations/#{@id}/merchant_funded_credit?payment_token_data=#{@payment_token_data}"
      end
    end
  end
end
