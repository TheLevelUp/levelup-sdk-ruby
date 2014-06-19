require 'spec_helper'

describe 'Levelup::Endpoints::MerchantFundedCredits', vcr: true do
  describe '#give' do
    it 'grants a user credit' do
      response = @test_client.merchant_funded_credits.give(
        email: 'pos@thelevelup.com',
        value_amount: 5,
        merchant_access_token: TestConfig.
          merchant_token_with_grant_credit_perms
      )

      expect(response).to be_success
    end
  end
end
