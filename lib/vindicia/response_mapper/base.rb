module Vindicia::ResponseMapper
  class Base
    def initialize(response)
      @response = response
    end

    #def map
      #throw 'define in subclass'
    #end

    #def _map(response, instance)
      ##case response[:object] ##when 'Error'
        ##puts response
        ##throw Vindicia::Exception.new(response[:message])
      ##else
        ##klass = "Vindicia::ResponseMapper::#{response[:object]}".constantize
        ##klass.new(instance).map(response)
      ##end
    #end

    def self.map(response)
      "Vindicia::ResponseMapper::#{response['object']}".constantize.new(response).map
    end

    private

    def model_klass
      "Vindicia::Model::#{self.class.name.split('::').last}".constantize
    end
  end
end

require 'vindicia/response_mapper/list'
require 'vindicia/response_mapper/product'
require 'vindicia/response_mapper/billing_plan'
require 'vindicia/response_mapper/product_description'
require 'vindicia/response_mapper/entitlement'
require 'vindicia/response_mapper/product_price'
require 'vindicia/response_mapper/billing_plan_period'
