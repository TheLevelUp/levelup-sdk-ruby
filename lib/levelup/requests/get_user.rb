module Levelup
  module Requests
    # Represents a request to get information about a user.
    # User access token must have the read_user_basic_info permission.
    class GetUser < Base
      include Templates::UserAuthenticated

      def body
        {}
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['user'])
      end
    end
  end
end
