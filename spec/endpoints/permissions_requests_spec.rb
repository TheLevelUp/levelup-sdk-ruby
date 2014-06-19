require 'spec_helper'

describe 'Levelup::Endpoints::PermissionsRequests', vcr: true do
  before do
    @test_client.api_key = TestConfig.api_key_valid
    @test_client.secret = TestConfig.secret_valid
    auth = @test_client.access_tokens.create_for_app
    @test_client.app_access_token = auth.token
  end

  describe '#create' do
    it 'submits a permissions request' do
      response = @test_client.apps.permissions_requests.create(
        email: TestConfig.user_email,
        permission_keynames: ['create_orders']
      )

      expect(response).to be_success
      expect(response.state).to eq('pending')
    end
  end
end
