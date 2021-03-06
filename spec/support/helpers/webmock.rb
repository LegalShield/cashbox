require 'webmock/rspec'

WebMock.disable_net_connect!

FIXTURE_PATH = File.expand_path('../../fixtures', __FILE__)

def stub_get(path)
  stub_request(:get, Cashbox::Request.base_uri + path)
end

def stub_post(path)
  stub_request(:post, Cashbox::Request.base_uri + path)
end

def a_get(path)
  a_request(:get, Cashbox::Request.base_uri + path)
end

def fixture(file)
  File.read("#{FIXTURE_PATH}/#{file}.json").strip
end
