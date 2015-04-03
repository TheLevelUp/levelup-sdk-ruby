require 'spec_helper'

describe 'Levelup::Requests::ListLocations' do
  before do
    @test_list_locs_request = Levelup::Requests::ListLocations.new
  end

  describe '#auth_type' do
    it 'returns :merchant_v14' do
      @test_list_locs_request.auth_type.should eq(:merchant_v14)
    end
  end
end
