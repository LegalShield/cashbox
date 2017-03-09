module Vindicia::Model
  #class Base
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

Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
  next if file =~ /base/
  require(file)
end
