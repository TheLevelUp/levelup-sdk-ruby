module Levelup
  module Endpoints
    # The class describing the behavior required of all endpoints.
    class Base
      private

      # Constructs the specified class out of the supplied hash. If the first
      # parameter is not a hash, simply returns it.
      def build_request(request, building_class)
        request.is_a?(Hash) ? building_class.new(request) : request
      end

      # Builds a path to this endpoint dynamically.
      def endpoint_path(version = Configuration::DEFAULT_API_VERSION)
        Configuration.api_url(version) + "/#{path}"
      end

      # Determines the name of this endpoint for purposes of building a URL.
      def path
        raise NotImplementedError,
          'Attempted to access endpoint with undefined path.'
      end
    end
  end
end
