module Levelup
  module Requests
    # The class containing the base functionality of all requests.
    class Base < Templates::DataParcel
      ALLOWED_REQUEST_METHODS = [:delete, :get, :post, :put]

      # One of :none, :merchant, :app, :merchant_and_user
      def auth_type
        raise NotImplementedError, 'Auth type not defined for request.'
      end

      # Returns the body of the request to send as a hash. By default, sends
      # a hash of all assigned instance variables in the object.
      def body
        to_hash
      end

      # Contains any additional headers passed in a request to the API.
      # Builds the headers for a request out of a request object.
      # Extending classes wishing to add additional headers should build their
      # headers hash and return my_headers.merge(super)
      def headers
        headers = DEFAULT_HEADERS.dup

        auth = auth_header_value
        if auth
          headers['Authorization'] = auth
        end

        headers
      end

      # default values to exclude from request hashes (header values)
      def self.instance_variables_excluded_from_hash
        @excluded ||= super.concat([:app_access_token, :merchant_access_token,
          :user_access_token])
      end

      def response_from_hash
        raise NotImplementedError, 'Response generator not defined.'
      end

      # Makes a call by the specified method to the specified endpoint, sending
      # this request object. If successful, builds a response object according
      # to response_from_hash. If unsuccessful, simply returns an ErrorResponse.
      def send_to_api(method, endpoint)
        unless ALLOWED_REQUEST_METHODS.include?(method)
          raise Errors::InvalidRequest, 'Attempted to send a request to'\
          " LevelUp API via invalid method #{method}"
        end

        response = HTTParty.public_send(method, endpoint,
          body: JSON.generate(body), headers: headers)

        if response.success?
          response_from_hash(response.parsed_response)
        else
          Responses::Error.new(response.headers, response.parsed_response,
            response.code)
        end
      end

      private

      DEFAULT_HEADERS = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      def auth_header_value
        case auth_type
        when :app
          %{token #{app_access_token}}
        when :merchant
          %{token merchant="#{merchant_access_token}"}
        when :merchant_v14
          %{token #{merchant_access_token}}
        when :merchant_and_user
          %{token merchant="#{merchant_access_token}", } +
            %{user="#{user_access_token}"}
        when :user
          %{token user="#{user_access_token}"}
        end
      end
    end
  end
end
