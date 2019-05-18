require 'bundler/setup'
require 'dotenv/load'
require 'coveralls'
Coveralls.wear!

require 'nasa'
require_relative 'nasa_helper'
require 'webmock/rspec'

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('REDACTED') { ENV['nasa_api_key'] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec
end
