module Levelup
  module Endpoints
    # The endpoint holding all functions related to accessing a specified
    # permissions request.
    class SpecificPermissionsRequest < Base
      def initialize(request_id, app_access_token)
        self.app_access_token = app_access_token
        self.request_id = request_id
      end

      def show
        request = Requests::ShowPermissionsRequest.
          new(app_access_token: app_access_token)
        request.send_to_api(:get, endpoint_path)
      end

      private

      attr_accessor :request_id, :app_access_token

      def path
        "apps/permissions_requests/#{request_id}"
      end
    end
  end
end
