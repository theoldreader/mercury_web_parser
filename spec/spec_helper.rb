require File.expand_path(File.dirname(__FILE__) + '/../lib/mercury_web_parser')
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :faraday
end
