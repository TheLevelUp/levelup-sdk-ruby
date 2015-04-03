require 'spec_helper'

describe 'Levelup::Endpoints::LocationCredit', vcr: true do
  describe '#get' do
    context 'with a valid user token' do
      it 'returns a credit value at a location' do
        response = @test_client.locations(TestConfig.location_id).credit.
          get(TestConfig.user_token_with_manage_campaigns_perms)
        expect(response).to be_success
        expect(response.total_amount).to_not be_nil
      end
    end

    context 'with an invalid user token' do
      it 'returns an error response' do
        response = @test_client.locations(TestConfig.location_id).credit.get('1234')
        expect(response).to_not be_success
      end
    end
  end
end
