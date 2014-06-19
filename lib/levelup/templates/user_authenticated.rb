module Levelup
  module Templates
    # A template to apply to any requests requiring user authentication.
    #
    # Authentication template - only apply one authentication template per
    # request.
    module Templates::UserAuthenticated
      # An access token for a user that has granted you appropriate
      # permissions.
      attr_accessor :user_access_token

      def auth_type
        :user
      end
    end
  end
end
