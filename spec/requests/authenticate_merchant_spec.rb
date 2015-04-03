require 'spec_helper'

describe 'Levelup::Requests::AuthenticateMerchant' do
  before do
    @test_merchant_authenticate_request = \
      Levelup::Requests::AuthenticateMerchant.new({})
  end

  describe '#auth_type' do
    it 'returns :none' do
      expect(@test_merchant_authenticate_request.auth_type).to be :none
    end
  end
end
