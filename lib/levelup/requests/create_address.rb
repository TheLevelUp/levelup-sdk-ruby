 module Levelup
  module Requests
    # Represents a request to create an address for a
    # specific user. For information about its parameters, see UserAddressData
    # and UserAuthenticated.
    class CreateAddress < Base
      include Templates::UserAddressData
      include Templates::UserAuthenticated

      def body
        { user_address: to_hash }
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['user_address'])
      end
    end
  end
end
