require 'active_support/inflector'
require 'addressable/uri'
require 'active_support/concern'

module Cashbox::Rest
  module Helpers
    DEFAULT_LIMIT = 100.freeze

    extend ActiveSupport::Concern

    included do
      def route(id=nil)
        self.class.route(id)
      end

      def cast(hash)
        self.class._cast(self, hash)
      end
    end

    class_methods do

      def cast(hash)
        self._cast(self.new, hash)
      end

      def route(id=nil)
        class_name = self.name.split('::').last
        tableized_class_name = ActiveSupport::Inflector.tableize(class_name)
        [ '', tableized_class_name, id ].compact.join('/')
      end

      def _cast(instance, hash)
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

      def _where(query, max)
        query = Hashie::Mash.new(query)

        query.limit ||= DEFAULT_LIMIT
        query.limit = query.limit.to_i
        query.limit = max if max && max < query.limit

        response = Cashbox::Request.new(:get, route, { query: query }).response
        objects = cast(response)

        if (response.next && (max.nil? || objects.count < max))
          max -= objects.count if max
          query = Addressable::URI.parse(response.next).query_values
          objects.concat(_where(query, max))
        end

        objects
      end

    end
  end
end
