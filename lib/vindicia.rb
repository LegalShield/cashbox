require 'httparty'
require 'hashie'

require 'vindicia/type'
require 'vindicia/model'
require 'vindicia/repository'
require 'vindicia/request'
require 'vindicia/response'

module Vindicia
  autoload :VERSION, 'vindicia/version'
  autoload :Exception, 'vindicia/exception'

  class << self
    attr_accessor :username, :password
  end

  def self.sandbox!
    Vindicia::Request.base_uri('https://api.prodtest.vindicia.com')
  end

  def self.test!
    Vindicia::Request.base_uri('http://example.com')
    Vindicia.username = 'username'
    Vindicia.password = 'password'
  end
end

