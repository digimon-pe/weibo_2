require 'simplecov'
require 'coveralls'
require 'vcr'
require 'webmock/rspec'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

WebMock.disable_net_connect!(allow: 'coveralls.io')

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.allow_http_connections_when_no_cassette = true
  config.hook_into :webmock
end

require 'weibo_2'
