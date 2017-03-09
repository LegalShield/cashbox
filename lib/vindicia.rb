require 'httparty'
require 'hashie'

require 'vindicia/type/list'
require 'vindicia/type/date_time'
require 'vindicia/repository/base'
require 'vindicia/request_mapper/base'
require 'vindicia/response_mapper'
require 'vindicia/model/base'
#require 'vindicia/exception'

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
