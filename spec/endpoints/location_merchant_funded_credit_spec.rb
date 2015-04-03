require 'spec_helper'

describe 'Levelup::Endpoints::LocationMerchantFundedCredit', vcr: true do
  describe '#get' do
    it 'gets a users credit' do
      response = @test_client.locations(TestConfig.location_id).merchant_funded_credit.
        get(TestConfig.user_qr_code, TestConfig.merchant_token_with_manage_orders_perms)

      expect(response).to be_success
    end
  end
end
