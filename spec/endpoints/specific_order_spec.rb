require 'spec_helper'

describe 'Levelup::Endpoints::SpecificOrder', vcr: true do
  describe '#refund' do
    context 'with an invalid UUID' do
      it 'returns an error response' do
        response = @test_client.orders('0').refund(@merchant_token_with_create_privs)
        expect(response).to_not be_success
      end
    end

    context 'with a valid UUID' do
      it 'refunds the specified order' do
        order_response = @test_client.orders.create(
          items: [],
          location_id: TestConfig.location_id,
          spend_amount: 10,
          merchant_access_token:
            TestConfig.merchant_token_with_manage_orders_perms,
          user_access_token:
            TestConfig.user_token_with_create_orders_perms
        )
        expect(order_response).to be_success

        refund_response = @test_client.orders(order_response.uuid).refund(
          TestConfig.merchant_token_with_manage_orders_perms)
        expect(refund_response).to be_success
        expect(refund_response.uuid).to eq(order_response.uuid)
      end
    end
  end
end
