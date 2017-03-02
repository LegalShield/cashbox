require 'httparty'
require 'hashie'

module Vindicia; end

Dir[File.dirname(__FILE__) + '/concerns/*.rb'].each {|f| require f }
Dir[File.dirname(__FILE__) + '/types/*.rb'].each {|f| require f }

require_relative 'repositories/base'
require_relative 'models/base'
require_relative 'request_mapper/base'
require_relative 'response_mapper/base'

Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|f| require f }

Vindicia::Model.constants.each do |constant|
  next if constant.to_s == 'Base'
  Vindicia.const_set(constant, Vindicia::Model.const_get(constant))
end

Vindicia::Type.constants.each do |constant|
  next if constant.to_s == 'Base'
  Vindicia.const_set(constant, Vindicia::Type.const_get(constant))
end
