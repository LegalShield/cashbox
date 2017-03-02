module Vindicia::Concern
  module Assignable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def field(name, options = {})
        type = options[:type]

        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |value|
          value = case(type)
                  when NilClass then value
                  when Proc then type.call(value)
                  else type.parse(value)
                  end

          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
