require 'spec_helper'

describe 'Levelup::Requests::RequestPermissions' do
  before do
    @test_user_permissions_request =
      Levelup::Requests::RequestPermissions.new({})
  end

  describe '#auth_type' do
    it 'returns :app' do
      expect(@test_user_permissions_request.auth_type).to be :app
    end
  end

  describe '#body' do
    it 'returns a hash wrapped in a permissions_request tag' do
      expect(@test_user_permissions_request.body[:permissions_request]).
        to_not be_nil
    end
  end
end
