module Vindicia::Model
  class Base < Hashie::Trash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Dash::Coercion

    def object
      self.class.name.split('::').last
    end

    #def to_json(*options)
      #as_json(*options).to_json(*options)
    #end
  end
end
