module Levelup
  class Configuration
    VERSION = '0.9.3'
    DEFAULT_API_VERSION = :v15

    class << self
      attr_accessor :base_api_url
    end

    self.base_api_url = 'https://api.thelevelup.com/'

    def self.api_url(version)
      base_api_url + VERSIONS[version]
    end

    private

    VERSIONS = {
      v14: 'v14',
      v15: 'v15'
    }
  end
end
