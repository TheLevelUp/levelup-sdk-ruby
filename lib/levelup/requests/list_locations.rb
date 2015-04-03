module Levelup
  module Requests
    # Represents a request to list all locations under a specified merchant.
    # This is a v14 endpoint and should not be expected to remain functional indefinitely.
    class ListLocations < Base
      include Templates::MerchantAuthenticated

      def auth_type
        :merchant_v14
      end

      def response_from_hash(hash)
        if hash.nil? # no locations found for this merchant
          Responses::Success.new(locations: [])
        else
          locations =
            hash.map { |location| OpenStruct.new(location['location']) }
          Responses::Success.new(locations: locations)
        end
      end
    end
  end
end
