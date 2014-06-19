module Levelup
  module Requests
    # Represents a request to show the status of a specified permissions
    # request.
    class ShowPermissionsRequest < Base
      attr_accessor :app_access_token

      def auth_type
        :app
      end

      def body
        {}
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['permissions_request'])
      end
    end
  end
end
