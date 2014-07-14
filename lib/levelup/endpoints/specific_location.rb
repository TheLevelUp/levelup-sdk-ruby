module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a specific location.
    # This is a v14 endpoint and should not be expected to remain functional
    # indefinitely.
    class SpecificLocation < Base
      attr_reader :id

      def initialize(location_id)
        @id = location_id
      end

      def orders
        LocationOrders.new(id)
      end

      def credit
        LocationCredit.new(id)
      end

      private

      def path
        "locations/#{id}"
      end
    end
  end
end
