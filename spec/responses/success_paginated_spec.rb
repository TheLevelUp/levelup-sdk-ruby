require 'spec_helper'

describe 'Levelup::Responses::SuccessPaginated', vcr: true do
  before do
    example_paginated_url = "#{Levelup::Configuration.api_url(:v14)}/apps/"\
      "#{TestConfig.app_id}/locations"
    @has_next_response = Levelup::Responses::SuccessPaginated.new
    @has_next_response.next_page = example_paginated_url
    @has_next_response.next_page_request =
      Levelup::Requests::ListAppLocations.new

    @no_next_response = Levelup::Responses::SuccessPaginated.new
  end

  describe '#success?' do
    it 'returns true' do
      expect(@has_next_response).to be_success
    end
  end

  describe '#next_page?' do
    context 'with no next page' do
      it 'returns false' do
        expect(@no_next_response.next_page?).to be_false
      end
    end

    context 'with another page to retrieve' do
      it 'returns true' do
        expect(@has_next_response.next_page?).to be_true
      end
    end
  end

  describe '#next' do
    context 'with no next page' do
      it 'raises an InvalidRequest error' do
        expect { @no_next_response.next }.to raise_error(Levelup::Errors::InvalidRequest)
      end
    end

    context 'with a next page' do
      it 'successfully returns the next page' do
        next_page_response = @has_next_response.next

        expect(next_page_response).to be_success
      end
    end
  end
end
