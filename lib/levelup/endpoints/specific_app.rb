module Levelup
  module Endpoints
    # The endpoint serving as a bucket for all functions related to a specific app.
    class SpecificApp < Base
      def initialize(id)
        self.id = id
      end

      def locations
        AppLocations.new(id)
      end

      private

      attr_accessor :id

      def path
        "apps/#{id}"
      end
    end
  end
end
