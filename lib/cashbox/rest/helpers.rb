require 'active_support/inflector'
require 'addressable/uri'
require 'active_support/concern'

module Cashbox::Rest
  module Helpers
    extend ActiveSupport::Concern

    included do
      def route(id=nil)
        self.class.route(id)
      end
    end

    class_methods do
      def route(id=nil)
        class_name = self.name.split('::').last
        tableized_class_name = ActiveSupport::Inflector.tableize(class_name)
        [ '', tableized_class_name, id ].compact.join('/')
      end

      def cast(instance, hash)
        case hash['object']
        when 'List'
          hash['data'].map do |data|
            instance.class.new(data)
          end
        when 'Error'
          raise Cashbox::Error.new(hash['message'])
        else
          instance.deep_merge!(hash)
        end
      end
    end
  end
end
