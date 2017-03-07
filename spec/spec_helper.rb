$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'pry'
require 'vindicia'

Dir[File.dirname(__FILE__) + '/support/helpers/*.rb'].each {|f| require(f) }
