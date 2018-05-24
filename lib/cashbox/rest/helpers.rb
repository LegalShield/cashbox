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
    end

    class_methods do
      def route(id=nil)
        class_name = self.name.split('::').last
        tableized_class_name = ActiveSupport::Inflector.tableize(class_name)
        [ '', tableized_class_name, id ].compact.join('/')
      end

      def query(params, max)
        params = Hashie::Mash.new(params)

        params.limit ||= DEFAULT_LIMIT
        params.limit = params.limit.to_i
        params.limit = max if max && max < params.limit

        response = Cashbox::Request.new(:get, route, { query: params }).response
        objects = cast(self.new, response)

        if (response.next && (max.nil? || objects.count < max))
          max -= objects.count if max
          params = Addressable::URI.parse(response.next).query_values
          objects.concat(query(params, max))
        end

        objects
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
