require 'httparty'
require 'hashie'

require 'vindicia/type'
#require 'vindicia/concern'
require 'vindicia/model'
require 'vindicia/repository'
require 'vindicia/request_mapper'
require 'vindicia/response_mapper'
require 'vindicia/request'
require 'vindicia/response'

module Vindicia
  class << self
    attr_accessor :username, :password
  end

  def self.sandbox!
    Vindicia::Repository::Base.base_uri('https://api.prodtest.vindicia.com')
  end

  def self.test!
    Vindicia::Repository::Base.base_uri('http://example.com')
    Vindicia.username = 'username'
    Vindicia.password = 'password'
  end
end

autoload :VERSION, 'vindicia/version'
