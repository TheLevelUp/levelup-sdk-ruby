module Levelup
  module Requests
    # Represents a request to get a QR code for a user.
    class GetQrCode < Base
      include Templates::UserAuthenticated

      def body
        {}
      end

      def response_from_hash(hash)
        Responses::Success.new(hash['qr_code'])
      end
    end
  end
end
