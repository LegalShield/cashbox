require 'webmock/rspec'

WebMock.disable_net_connect!

FIXTURE_PATH = File.expand_path('../../fixtures', __FILE__)

puts 'here'
def stub_get(path)
  stub_request(:get, Vindicia::Repository::Base.base_uri + path)
end

def a_get(path)
  a_request(:get, Vindicia::Repository::Base.base_uri + path)
end

def fixture(file)
  File.read("#{FIXTURE_PATH}/#{file}.json").strip
end
