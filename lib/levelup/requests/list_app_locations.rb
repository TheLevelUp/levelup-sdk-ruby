module Levelup
  module Requests
    # Represents a request to list all locations under
    # a specified app. The list is paginated.
    class ListAppLocations < Base
      def auth_type
        :none
      end

      def response_from_hash(hash)
        if hash.nil? # no locations found for this app
          Responses::SuccessPaginated.new(locations: [])
        else
          locations =
            hash.map { |location| OpenStruct.new(location['location']) }
          Responses::SuccessPaginated.new(locations: locations)
        end
      end

      def send_to_api(method, endpoint)
        send_via_httparty(method, endpoint) do |response|
          paginated_response = response_from_hash(response)

          if response.headers['Link']
            paginated_response.next_page =
              /\<([^>]+)\>/.match(response.headers['Link'])[1]
            paginated_response.next_page_request = ListAppLocations.new
          end

          paginated_response
        end
      end
    end
  end
end
