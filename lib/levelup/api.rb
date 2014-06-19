# The LevelUp Ruby SDK provides an interface for Ruby and Rails developers to
# easily and intuitively access the LevelUp API, specifically for the purpose
# of utilizing LevelUp for online ordering and web payments.

module Levelup
  # This API is the base class that handles all requests made to the LevelUp
  # API.
  class Api
    # Token to access app-authenticated endpoints
    attr_writer :app_access_token
    # App API key to automatically generate an app access token
    attr_writer :api_key
    # App secret to automatically generate an app access token
    attr_writer :secret

    # Accepts any combination of the listed parameters, though +api_key+ and
    # +secret+ work in tandem.
    def initialize(app_access_token: nil, api_key: nil, secret: nil)
      self.app_access_token = app_access_token
      self.api_key = api_key
      self.secret = secret
    end

    # Generates an interface for the +access_tokens+ endpoint.
    def access_tokens
      Endpoints::AccessTokens.new(
        api_key: api_key,
        secret: secret
      )
    end

    # Generates an interface for the +apps+ endpoint.
    def apps(app_id = nil)
      if app_id
        Endpoints::SpecificApp.new(app_id)
      else
        Endpoints::Apps.new(app_access_token)
      end
    end

    # Verifies if an access token is present for app-authenticated endpoints
    def app_authenticated?
      !@app_access_token.nil?
    end

    def credit_cards
      Endpoints::CreditCards.new
    end

    # Generates the interface for the +locations+ endpoint for a specific
    # location ID.
    def locations(location_id)
      Endpoints::SpecificLocation.new(location_id)
    end

    # Generates an interface for the +merchants+ endpoint for a specific
    # merchant ID.
    def merchants(merchant_id)
      Endpoints::SpecificMerchant.new(merchant_id)
    end

    def merchant_funded_credits
      Endpoints::MerchantFundedCredits.new
    end

    # Generates the interface for the +orders+ endpoint. Supply an order UUID if
    # you would like to access endpoints for a specific order, otherwise, supply
    # no parameters.
    def orders(order_uuid = nil)
      if order_uuid
        Endpoints::SpecificOrder.new(order_uuid)
      else
        Endpoints::Orders.new
      end
    end

    def qr_codes
      Endpoints::QrCodes.new
    end

    # Generates an interface the +user_addresses+ endpoint.
    def user_addresses
      Endpoints::UserAddresses.new
    end

    def users
      Endpoints::Users.new
    end

    private

    attr_reader :api_key, :secret

    def app_access_token
      unless app_authenticated?
        auto_auth = access_tokens.create_for_app

        if auto_auth.success?
          @app_access_token = auto_auth.token
        end
      end

      @app_access_token
    end
  end
end
