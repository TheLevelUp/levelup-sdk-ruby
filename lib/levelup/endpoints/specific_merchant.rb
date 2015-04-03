module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a single merchant. This is
    # a v14 endpoint and should not be expected to remain functional indefinitely.
    class SpecificMerchant < Base
      def initialize(merchant_id)
        self.id = merchant_id
      end

      def locations
        MerchantLocations.new(id)
      end

      def orders
        MerchantOrders.new(id)
      end

      private

      attr_accessor :id

      def path
        "merchants/#{id}"
      end
    end
  end
end
