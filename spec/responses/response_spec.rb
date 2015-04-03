require 'spec_helper'

describe 'Levelup::Responses::Success' do
  before do
    @test_response = Levelup::Responses::Success.new({})
  end

  describe '#success?' do
    it 'returns true' do
      expect(@test_response.success?).to be_true
    end
  end
end
