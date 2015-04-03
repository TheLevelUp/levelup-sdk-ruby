module Levelup
  module Requests
    # Represents a request to create an order for the specified user at the specified merchant.
    class CreateOrder < Base
      include Templates::MerchantAndUserAuthenticated
      # An array of Item objects (or hashes representing them) representing all
      # items purchased by this order.
      attr_accessor :items
      # A merchant-supplied unique ID for this order. Optional.
      attr_accessor :identifier_from_merchant
      # The LevelUp ID for the location from which this order was requested.
      attr_accessor :location_id
      # The total amount (in cents) spent on this order.
      attr_accessor :spend_amount

      def body
        items = (@items || []).map do |item|
          if item.empty?
            next
          end

          { item: item }
        end

        order_hash = to_hash
        order_hash[:items] = items

        { order: order_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['order'])
      end
    end
  end
end
