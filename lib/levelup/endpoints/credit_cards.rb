module Levelup
  module Endpoints
    # The endpoint holding all functions related to managing users' credit cards.
    class CreditCards < Base
      # Adds a credit card to a user's account. Requires a user access token
      # with create_first_credit_card permission.
      # This request will fail unless the user account has no credit card on it.
      def create(credit_card_request)
        build_request(credit_card_request, Requests::CreateCard).
          send_to_api(:get, endpoint_path)
      end

      private

      def path
        'credit_cards'
      end
    end
  end
end
