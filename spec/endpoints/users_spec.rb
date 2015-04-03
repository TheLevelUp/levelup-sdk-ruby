require 'spec_helper'

describe 'Levelup::Endpoints::GetUsers', vcr: true do
  describe '#get' do
    context 'with an invalid access token' do
      it 'returns an error response' do
        response = @test_client.users.get('invalid')
        expect(response).to_not be_success
      end
    end

    context 'with a valid access token' do
      it 'returns the user\'s info' do
        response = @test_client.users.get(
          TestConfig.user_token_with_read_info_perms)

        expect(response).to be_success
        expect(response.email).to_not be_nil
      end
    end
  end
end
