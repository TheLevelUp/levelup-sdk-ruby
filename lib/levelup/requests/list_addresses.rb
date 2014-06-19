 module Levelup
  module Requests
    # Represents a request to create an address for a
    # specific user. For information about its parameters, see UserAddressData
    # and UserAuthenticated.
    # User access token must have the manage_user_addresses permission.
    class ListAddresses < Base
      include Templates::UserAuthenticated

      def body
        {}
      end

      def response_from_hash(hash)
        addresses = hash.map { |address| address['user_address'] }
        Responses::Success.new(addresses: addresses)
      end
    end
  end
end
