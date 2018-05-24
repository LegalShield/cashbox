module Cashbox
  class Model < Hashie::Trash
    def self.included(base)
      base.class_eval do
        property :object, transform_with: -> (v) { self.name.split('::').last }, default: -> { self.name.split('::').last }
      end
    end

    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Dash::PropertyTranslation
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::DeepMerge
  end
end
