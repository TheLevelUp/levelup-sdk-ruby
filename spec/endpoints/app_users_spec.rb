require 'spec_helper'

describe 'Levelup::Endpoints::AppUsers', vcr: true do
  before do
    @test_client.api_key = TestConfig.api_key_valid
    @test_client.secret = TestConfig.secret_valid
    auth = @test_client.access_tokens.create_for_app
    @test_client.app_access_token = auth.token
  end

  describe '#create' do
    it 'creates a user' do
      response = @test_client.apps.users.create(
        email: 'some@email.com',
        first_name: 'firstname',
        last_name: 'lastname',
        permission_keynames: ['create_orders']
      )

      expect(response).to be_success
      expect(response.user.last_name).to eq('lastname')
    end
  end

  describe '#get' do
    context 'with an invalid access token' do
      it 'returns an error response' do
        response = @test_client.apps.users.get('invalid')
        expect(response).to_not be_success
      end
    end

    context 'with a valid access token' do
      it 'returns the user\'s info' do
        response = @test_client.apps.users.get(
          TestConfig.user_token_with_read_info_perms)

        expect(response).to be_success
        expect(response.email).to_not be_nil
      end
    end
  end
end
