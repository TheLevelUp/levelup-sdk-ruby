module Levelup
  module Requests
    # Represents a request to create a new user with the specified list of
    # permissions.
    class CreateUser < Base
      attr_accessor :app_access_token
      # An array of Item objects (or hashes representing them) representing all
      # items purchased by this order.
      attr_accessor :email
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :permission_keynames

      def auth_type
        :app
      end

      def body
        user_hash = {
          email: email,
          first_name: first_name,
          last_name: last_name
        }
        { user: user_hash, permission_keynames: permission_keynames }
      end

      def response_from_hash(hash)
        hash['user'] = OpenStruct.new(hash['user'])

        Responses::Success.new(hash)
      end
    end
  end
end
