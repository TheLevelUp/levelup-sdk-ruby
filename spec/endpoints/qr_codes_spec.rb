require 'spec_helper'

describe 'Levelup::Endpoints::QrCodes', vcr: true do
  describe '#get' do
    it 'retrieves a user\'s QR code' do
      response = @test_client.qr_codes.get(TestConfig.
        user_token_with_read_qr_perms)
      expect(response).to be_success
      expect(response.code).to_not be_nil
    end
  end
end
