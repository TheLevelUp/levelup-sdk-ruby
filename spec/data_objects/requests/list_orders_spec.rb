require 'spec_helper'

describe 'Levelup::Requests::ListOrders' do
  before do
    @test_list_orders_request = Levelup::Requests::ListOrders.new
  end

  describe '#auth_type' do
    it 'returns :merchant_v14' do
      @test_list_orders_request.auth_type.should eq(:merchant_v14)
    end
  end
end
