module Levelup
  module Templates
    # A template to apply to any requests requiring app authentication.
    #
    # Authentication template - only apply one authentication template per
    # request.
    module AppAuthenticated
      # An access token for an app.
      attr_accessor :app_access_token

      def auth_type
        :app
      end
    end
  end
end
