require 'spec_helper'

describe 'Levelup::Endpoints::UserAddresses', vcr: true do
  describe '#create' do
    before do
      @test_address_hash = {
        address_type: 'home',
        street_address: '1 Levelup Lane',
        extended_address: 'Suite 3',
        locality: 'Boston',
        region: 'MA',
        postal_code: '02114'
      }
      @test_client.api_key = TestConfig.api_key_valid
      @test_client.secret = TestConfig.secret_valid
    end

    context 'with an invalid user token' do
      it 'returns an error response' do
        test_request =
          Levelup::Requests::CreateAddress.new(@test_address_hash)
        test_request.user_access_token = 'invalid'
        response = @test_client.user_addresses.create(test_request)
        expect(response).to_not be_success
      end
    end

    context 'with a valid user token' do
      it 'returns a successful creation response' do
        test_request =
          Levelup::Requests::CreateAddress.new(@test_address_hash)
        test_request.user_access_token =
          TestConfig.user_token_with_manage_addresses_perms
        response = @test_client.user_addresses.create(test_request)
        expect(response).to be_success
        expect(response.street_address).
          to eq(@test_address_hash[:street_address])
      end
    end
  end
end
