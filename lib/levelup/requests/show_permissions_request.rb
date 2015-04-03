module Levelup
  module Requests
    # Represents a request to show the status of a specified permissions request.
    class ShowPermissionsRequest < Base
      include Templates::AppAuthenticated

      def body
        {}
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['permissions_request'])
      end
    end
  end
end
