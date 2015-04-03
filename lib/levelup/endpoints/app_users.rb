module Levelup
  module Endpoints
    # The endpoint holding all functions related to managing users under the current app.
    class AppUsers < Base
      def initialize(app_access_token)
        @app_access_token = app_access_token
      end

      def create(create_user_request)
        request = build_request(create_user_request, Requests::CreateUser)
        request.app_access_token ||= app_access_token
        request.send_to_api(:post, endpoint_path)
      end

      private

      attr_reader :app_access_token

      def path
        'apps/users'
      end
    end
  end
end
