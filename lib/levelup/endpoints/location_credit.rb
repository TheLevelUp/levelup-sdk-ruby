module Levelup
  module Endpoints
    # The endpoint holding all functions relating to available credit at locations.
    class LocationCredit < Base
      def initialize(location_id)
        self.id = location_id
      end

      def get(user_access_token)
        Requests::GetLocationCredit.new(user_access_token: user_access_token).
          send_to_api :get, endpoint_path
      end

      private

      attr_accessor :id

      def path
        "locations/#{id}/credit"
      end
    end
  end
end
