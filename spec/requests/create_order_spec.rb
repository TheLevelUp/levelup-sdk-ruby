require 'spec_helper'

describe 'Levelup::Requests::CreateOrder' do
  before do
    @test_app_order_request = Levelup::Requests::CreateOrder.new(
        user_access_token: 'some access token', location_id: 256)
  end

  describe '#auth_type' do
    it 'returns :merchant_and_user' do
      expect(@test_app_order_request.auth_type).to be :merchant_and_user
    end
  end
end
