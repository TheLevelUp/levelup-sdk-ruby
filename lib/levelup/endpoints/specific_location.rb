module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a specific location.
    # This is a v14 endpoint and should not be expected to remain functional indefinitely.
    class SpecificLocation < Base
      attr_accessor :id

      def initialize(location_id)
        self.id = location_id
      end

      def credit
        LocationCredit.new(id)
      end

      def merchant_funded_credit
        LocationMerchantFundedCredit.new(id)
      end

      def orders
        LocationOrders.new(id)
      end

      private

      attr_accessor :id

      def path
        "locations/#{id}"
      end
    end
  end
end
