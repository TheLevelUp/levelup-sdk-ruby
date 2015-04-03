$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'levelup/configuration'

Gem::Specification.new do |spec|
  spec.name          = 'levelup'
  spec.version       = Levelup::Configuration::VERSION
  spec.authors       = ['LevelUp POS Team']
  spec.email         = ['pos-support@thelevelup.com']
  spec.summary       = %q(A Ruby client for communicating with the LevelUp API)
  spec.description   = %q(A tool to simplify, streamline, and quickly
    communicate with the LevelUp REST API, allowing for companies to easily
    implement the ability to pay with LevelUp on their e-commerce platforms.)
  spec.homepage      = 'http://developer.thelevelup.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3.1'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'rspec-mocks', '~> 2.14.6'
  spec.add_development_dependency 'rubocop', '~> 0.16.0'
  spec.add_development_dependency 'settingslogic', '~> 2.0.9'
  spec.add_development_dependency 'vcr', '~> 2.9.0'
  spec.add_development_dependency 'webmock', '~> 1.17.4'

  spec.add_runtime_dependency 'httparty', '~> 0.13.1'

  spec.required_ruby_version = '>= 2.0.0'
end
