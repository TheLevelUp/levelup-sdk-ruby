require 'spec_helper'

describe 'Levelup::Responses::Error' do
  before do
    @empty_response = Levelup::Responses::Error.new({}, [], 404)

    @nonempty_response = Levelup::Responses::Error.new(
      {
        'header' => 'value',
        'otherHeader' => 'secondValue'
      },
      [{
        'error' => {
          'property' => 'whatever',
          'object' => 'Elbereth',
          'message' => 'some message'
        }
      },
      {
        'error' => {
          'property' => 'some_prop',
          'object' => 'some_object',
          'message' => 'some other message'
        }
      }],
      404)
  end

  describe '#errors' do
    context 'for an object with no body hash' do
      it 'has no errors' do
        expect(@empty_response.errors).to eq([])
      end
    end

    context 'for an object with two full errors in its body hash' do
      it 'has two full errors' do
        expect(@nonempty_response).to have(2).errors
        @nonempty_response.errors.each do |error|
          expect(error.property).to_not be_nil
          expect(error.object).to_not be_nil
          expect(error.message).to_not be_nil
        end
      end
    end
  end

  describe '#headers' do
    context 'for an object with an empty supplied header' do
      it 'has empty headers' do
        expect(@empty_response.headers).to eq({})
      end
    end

    context 'for an object with a nonempty supplied header' do
      it 'has non-empty headers' do
        expect(@nonempty_response.headers).to_not be_empty
      end
    end
  end

  describe '#success?' do
    it 'returns false' do
      expect(@empty_response.success?).to be_false
    end
  end
end
