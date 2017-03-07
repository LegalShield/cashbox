require 'httparty'

require 'vindicia/repository'
require 'vindicia/request_mapper'
require 'vindicia/response_mapper'
#require 'vindicia/model'

module Vindicia
  class << self
    attr_accessor :username, :password
  end

  def self.sandbox!
    Vindicia::Repository.base_uri('https://api.prodtest.vindicia.com')
  end
end

autoload :VERSION, 'vindicia/version'

#Dir[File.dirname(__FILE__) + '/vindicia/concerns/*.rb'].each {|f| require(f) }
#Dir[File.dirname(__FILE__) + '/vindicia/types/*.rb'].each {|f| require(f) }


#Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|f| require(f) }

#Vindicia::Model.constants.each do |constant|
  #next if constant.to_s == 'Base'
  #Vindicia.const_set(constant, Vindicia::Model.const_get(constant))
#end

#Vindicia::Type.constants.each do |constant|
  #next if constant.to_s == 'Base'
  #Vindicia.const_set(constant, Vindicia::Type.const_get(constant))
#end
