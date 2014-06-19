module Levelup
  module Endpoints
    # The endpoint serving as a bucket for all app-related functions.
    class Apps < Base
      def initialize(app_access_token)
        @app_access_token = app_access_token
      end

      def permissions_requests(request_id = nil)
        if request_id
          SpecificPermissionsRequest.new(request_id, app_access_token)
        else
          PermissionsRequests.new(app_access_token)
        end
      end

      def users
        AppUsers.new(app_access_token)
      end

      private

      attr_reader :app_access_token

      def path
        'apps'
      end
    end
  end
end
