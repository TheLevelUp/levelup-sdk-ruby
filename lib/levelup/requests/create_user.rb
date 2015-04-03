module Levelup
  module Requests
    # Represents a request to create a new user with the specified list of permissions.
    class CreateUser < Base
      include Templates::AppAuthenticated
      attr_accessor :permission_keynames
      attr_accessor :api_key
      attr_accessor :user

      def body
        { api_key: api_key, user: user, permission_keynames: permission_keynames }
      end

      def response_from_hash(hash)
        hash['user'] = OpenStruct.new(hash['user'])

        Responses::Success.new(hash)
      end
    end
  end
end
