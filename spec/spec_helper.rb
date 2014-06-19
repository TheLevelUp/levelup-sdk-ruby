require 'settingslogic'
require 'vcr'
require 'support/vcr_filter_sensitive_data'

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'levelup'

Levelup::Configuration.base_api_url = 'https://sandbox.thelevelup.com/'

class TestConfig < Settingslogic
  source 'spec/fixtures/keys.yml'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method, :uri, :body]
  }
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.before do
    @test_client = Levelup::Api.new
  end
end
