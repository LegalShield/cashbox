module Cashbox::Concern
  module Objectable
    def self.included(base)
      base.class_eval do
        property :object, transform_with: -> (v) { self.name.split('::').last }, default: -> { self.name.split('::').last }
      end
    end
  end
end
