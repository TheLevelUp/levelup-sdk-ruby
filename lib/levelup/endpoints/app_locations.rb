module Levelup
  module Endpoints
    # The endpoint holding all functions relating to a specific app's locations.
    # This endpoint is a v14 endpoint and should not be expected to remain accessible indefinitely.
    class AppLocations < Base
      def initialize(id)
        self.id = id
      end

      # Provides a list of locations controlled by this app. This list is paginated.
      def list
        Requests::ListAppLocations.new.
          send_to_api(:get, endpoint_path(:v14))
      end

      private

      attr_accessor :id

      def path
        "apps/#{id}/locations"
      end
    end
  end
end
