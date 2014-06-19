require 'spec_helper'

describe 'Levelup::Endpoints::AccessTokens', vcr: true do
  describe '#create_for_app' do
    context 'with no request object' do
      context 'with no predefined API key/app secret' do
        it 'fails to authenticate' do
          expect(@test_client.access_tokens.create_for_app).to_not be_success
        end
      end

      context 'with a predefined API key/app secret' do
        before do
          @test_client.api_key = TestConfig.api_key_valid
          @test_client.secret = TestConfig.secret_valid
        end

        it 'returns a successful authentication response' do
          response = @test_client.access_tokens.create_for_app
          expect(response).to be_success
          expect(response.token).to_not be_nil
          expect(response.token).to_not be_empty
        end
      end
    end

    context 'with invalid keys' do
      it 'returns an error response' do
        auth_request = Levelup::Requests::AuthenticateApp.new(
          api_key: 'wrong_api_key',
          client_secret: 'wrong_client_secret'
        )
        response = @test_client.access_tokens.create_for_app(auth_request)
        expect(response).to_not be_success
      end
    end

    context 'with valid keys' do
      it 'returns a successful authenticate response' do
        auth_request = Levelup::Requests::AuthenticateApp.new(
          api_key: TestConfig.api_key_valid,
          client_secret: TestConfig.secret_valid
        )
        response = @test_client.access_tokens.create_for_app(auth_request)
        expect(response).to be_success
        expect(response.token).to_not be_nil
      end
    end
  end

  describe '#create_for_merchant' do
    context 'with valid keys' do
      it 'returns a successful authentication response' do
        merchant_auth_request =
          Levelup::Requests::AuthenticateMerchant.new(
            api_key: TestConfig.merchant_api_key,
            username: TestConfig.merchant_username,
            password: TestConfig.merchant_password
          )

        response = @test_client.access_tokens.
          create_for_merchant(merchant_auth_request)
        expect(response).to be_success
        expect(response.token).to_not be_nil
      end
    end

    context 'with invalid keys' do
      it 'fails to authenticate' do
        merchant_auth_request = Levelup::Requests::AuthenticateMerchant.new(
          api_key: 'abc123',
          username: 'username_wrong',
          password: 'password1'
        )
        response = @test_client.access_tokens.
          create_for_merchant(merchant_auth_request)
        expect(response).to_not be_success
      end
    end
  end
end
