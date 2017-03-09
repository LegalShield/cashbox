module Vindicia::Model
  class Base < Hashie::Trash

    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Dash::Coercion
    #include Hashie::Extensions::MethodAccess

    def object
      self.class.name.split('::').last
    end
  end
end
