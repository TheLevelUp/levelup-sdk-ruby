module Levelup
  module Endpoints
    # The endpoint holding all functions related to managing users' QR codes.
    class QrCodes < Base
      def initialize(options = {})
        self.color = options[:color] || 0
        self.tip_amount = options[:tip_amount] || 0
        self.tip_percent = options[:tip_percent] || 0
      end

      # Retrieves the specified user's QR code using parameters specified
      # in the endpoint.
      def get(user_access_token)
        request = Requests::GetQrCode.new(user_access_token: user_access_token)
        request.send_to_api(:get, endpoint_path)
      end

      private

      attr_accessor :color, :tip_amount, :tip_percent

      def path
        "qr_codes?preferences[color]=#{color}&preferences[tip_amount]="\
        "#{tip_amount}&preferences[tip_percent]=#{tip_percent}"
      end
    end
  end
end
