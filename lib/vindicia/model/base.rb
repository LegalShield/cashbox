module Vindicia::Model
  class Base
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
