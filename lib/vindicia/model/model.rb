module Vindicia
  class Model < Hashie::Trash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Dash::PropertyTranslation
    include Hashie::Extensions::Dash::Coercion
  end
end
