module Levelup
  module Templates
    # Apply this template to any request/response that handles all data for a
    # user address.
    module UserAddressData
      # The 'type' of this address, e.g. 'home' or 'work'.
      attr_accessor :address_type
      # The number and street name of this address.
      attr_accessor :street_address
      # The second line of the address, e.g. 'Suite #40'.
      attr_accessor :extended_address
      # The city (or some equivalent) of this address.
      attr_accessor :locality
      # The state, province, or some other equivalent for this address.
      attr_accessor :region
      # The postal code for this address.
      attr_accessor :postal_code
    end
  end
end
