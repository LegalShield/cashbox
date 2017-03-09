require 'active_support/inflector'

module Vindicia::Repository
  class Base
    class << self
      def where(query = {})
        map_response(get(route, { limit: 100 }.merge(query)))
      end

      def all
        map_response(get(route, {}))
      end

      def first
        map_response(get(route, { limit: 1 })).first
      end

      def find(id)
        raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
        map_response(get(route(id)))
      end

      def save(model)
        map_response(post(route(model.id), Vindicia::RequestMapper::Base.map(model)))
      end

      private

      def map_response(response)
        Vindicia::Response.new(response)
      end

      def get(path, query = {})
        Vindicia::Request.new(:get, path, { query: query })
      end

      def post(path, body)
        Vindicia::Request.new(:post, path, { body: body.to_json })
      end

      def route(id=nil)
        class_name = self.name.split('::').last.downcase
        plural_class_name = ActiveSupport::Inflector.pluralize(class_name)
        [ '', plural_class_name, id ].compact.join('/')
      end
    end
  end
end
