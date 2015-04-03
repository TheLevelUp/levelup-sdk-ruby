module Levelup
  module Requests
    # Represents a request to add the first credit card to a specified user account.
    # User access token must have the create_first_credit_card permission.
    class CreateCard < Base
      include Templates::UserAuthenticated

      attr_accessor :encrypted_cvv, :encrypted_expiration_month,
        :encrypted_expiration_year, :encrypted_number, :postal_code

      def body
        { credit_card: to_hash }
      end

      def response_from_hash(hash)
        Response::Success.new(hash['credit_card'])
      end
    end
  end
end
