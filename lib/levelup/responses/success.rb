module Levelup
  module Responses
    # Class that encapsulates a successful response from the LevelUp API.
    class Success < OpenStruct
      # Whether the response represents a successful API call.
      def success?
        true
      end
    end
  end
end
