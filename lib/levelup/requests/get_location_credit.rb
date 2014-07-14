module Levelup
  module Requests
    # Represents a request to access information about a
    # specific order under a merchant.
    class GetLocationCredit < Base
      include Templates::UserAuthenticated

      def response_from_hash(hash)
        Responses::Success.new(hash['credit'])
      end
    end
  end
end
