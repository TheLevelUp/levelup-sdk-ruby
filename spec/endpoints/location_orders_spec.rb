require 'spec_helper'

describe 'Levelup::Endpoints::LocationOrders', vcr: true do
  before :all do
    VCR.use_cassette('merchant_auth') do
      merchant_auth = Levelup::Api.new.access_tokens.create_for_merchant(
        api_key: TestConfig.merchant_api_key,
        username: TestConfig.merchant_username,
        password: TestConfig.merchant_password
      )

      @test_merchant_auth_token = merchant_auth.token
    end
  end

  describe '#list' do
    context 'with a valid location' do
      it 'returns a list of orders' do
        response = @test_client.locations(TestConfig.location_id).orders.
          list(@test_merchant_auth_token)
        expect(response).to be_success
        expect(response.orders).to_not be_nil
      end
    end

    context 'with an invalid location' do
      it 'returns an error response' do
        response = @test_client.locations(-25).orders.list(@test_merchant_auth_token)
        expect(response).to_not be_success
      end
    end
  end
end
