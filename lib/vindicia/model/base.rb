module Vindicia::Model
  class Base < Hash
    def initialize(attributes = {})
      super()
      self.update_attributes(attributes)
    end

    def update_attributes(attributes = {})
      attributes.each do |name, value|
        self.instance_variable_set("@#{name}", value)
      end
      self
    end

    def object
      self.class.name.split('::').last
    end
  end
end

require 'vindicia/model/product'
require 'vindicia/model/billing_plan'
require 'vindicia/model/product_description'
require 'vindicia/model/entitlement'
require 'vindicia/model/product_price'
require 'vindicia/model/billing_plan_period'
