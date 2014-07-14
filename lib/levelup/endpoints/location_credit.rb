module Levelup
  module Endpoints
    # The endpoint holding all functions relating to available credit at
    # locations.
    class LocationCredit < Base
      attr_reader :id

      def initialize(location_id)
        @id = location_id
      end

      def get(user_access_token)
        request = 
          Requests::GetLocationCredit.new(user_access_token: user_access_token)
        request.send_to_api(:get, endpoint_path)
      end

      private

      def path
        "locations/#{id}/credit"
      end
    end
  end
end
