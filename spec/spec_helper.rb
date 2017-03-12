$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'pry'
require 'vindicia'
require 'rspec/its'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

Dir[File.dirname(__FILE__) + '/support/helpers/*.rb'].each {|f| require(f) }
Dir[File.dirname(__FILE__) + '/support/matchers/*.rb'].each {|f| require(f) }
