require 'spec_helper'

describe 'Levelup::Endpoints::MerchantLocations', vcr: true do
  before :all do
    VCR.use_cassette('merchant_auth') do
      merchant_auth = Levelup::Api.new.access_tokens.create_for_merchant(
        api_key: TestConfig.merchant_api_key,
        username: TestConfig.merchant_username,
        password: TestConfig.merchant_password
      )

      @test_merchant_auth_token = merchant_auth.token
      @test_merchant_id = merchant_auth.merchant_id
    end
  end

  describe '#list' do
    context 'with a valid merchant' do
      it 'returns a successful list-locations response' do
        response = @test_client.merchants(@test_merchant_id).locations.list(
          @test_merchant_auth_token)
        expect(response).to be_success
        expect(response.locations).to_not be_nil
      end
    end

    context 'with an invalid merchant' do
      it 'returns an error response' do
        response = @test_client.merchants(-25).locations.list(
          @test_merchant_auth_token)
        expect(response).to_not be_success
      end
    end
  end
end
