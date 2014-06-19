require 'spec_helper'

describe 'Levelup::Endpoints::AppLocations', vcr: true do
  describe '#list' do
    it 'fetches a list of locations' do
      response = @test_client.apps(TestConfig.app_id).locations.list

      expect(response).to be_success
      expect(response.locations.length).to be > 0
    end

    it 'fetches a second page of locations' do
      next_response = @test_client.apps(TestConfig.app_id).locations.list.next

      expect(next_response).to be_success
    end
  end
end
