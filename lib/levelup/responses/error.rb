module Levelup
  module Responses
    # Encapsulates a response to an unsuccessful request.
    class Error < Templates::DataParcel
      # An array of error hashes with the properties 'object' (the LevelUp API
      # object causing the error), 'property' (the property of that object
      # causing the error), and 'message' (a human-readable error message).
      attr_reader :errors
      # The HTTP status code returned by the API
      attr_reader :status_code
      # Any HTTP headers returned by the API, in hash form.
      attr_reader :headers

      # Builds the error from the raw JSON response and the specified status
      # code.
      def initialize(headers, errors, status_code)
        @headers = headers

        if errors.is_a?(Array) || !errors
          @errors = (errors || []).map do |error|
            OpenStruct.new(error['error'])
          end
        else
          @errors = [{ message: 'Could not parse error body' }]
        end

        @status_code = status_code
      end

      # Errors are always unsuccessful.
      def success?
        false
      end
    end
  end
end
