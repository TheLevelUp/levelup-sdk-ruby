module Levelup
  module Endpoints
    # The endpoint holding all functions related to managing permissions
    # requests.
    class PermissionsRequests < Base
      def initialize(app_access_token)
        self.app_access_token = app_access_token
      end

      # Requests a set of permissions from the specified user.
      # See RequestPermissionsRequest for more detail about parameters.
      def create(user_permissions_request)
        request = build_request(user_permissions_request,
          Requests::RequestPermissions)
        request.app_access_token ||= app_access_token
        request.send_to_api(:post, endpoint_path)
      end

      private

      attr_accessor :app_access_token

      def path
        'apps/permissions_requests'
      end
    end
  end
end
