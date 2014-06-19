module Levelup
  module Endpoints
    # The endpoint holding all functions related to managing users' QR codes.
    class QrCodes < Base
      def initialize(color: 0, tip_amount: 0, tip_percent: 0)
        self.color = color
        self.tip_amount = tip_amount
        self.tip_percent = tip_percent
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
