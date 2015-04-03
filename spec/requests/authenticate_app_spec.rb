require 'spec_helper'

describe 'Levelup::Requests::AuthenticateApp' do
  before do
    @test_authenticate_request = Levelup::Requests::AuthenticateApp.new
  end

  describe '#auth_type' do
    it 'returns :none' do
      expect(@test_authenticate_request.auth_type).to eq(:none)
    end
  end
end
