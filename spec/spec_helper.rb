$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'pry'
require 'vindicia'
require 'webmock/rspec'

WebMock.disable_net_connect!

FIXTURE_PATH = File.expand_path('../support/fixtures', __FILE__)

def stub_get(path)
  stub_request(:get, Vindicia::Repository.base_uri + path)
end

def a_get(path)
  a_request(:get, Vindicia::Repository::Base.base_uri + path)
end

def fixture(file)
  File.new(FIXTURE_PATH + '/' + file)
end

RSpec::Matchers.define :have_attr_accessor do |field|
  match do |object|
    if object.respond_to?("#{field}=") && object.respond_to?(field)
      object.send("#{field}=", nil)
      object.instance_variable_defined?("@#{field}".to_sym)
    end
  end

  failure_message do |object|
    "expected attr_accessor for #{field} on #{object}"
  end

  failure_message_when_negated do |object|
    "expected attr_accessor for #{field} not to be defined on #{object}"
  end

  description do
    "checks to see if there is an attr accessor on the supplied object"
  end
end
