require 'active_support/inflector'
require 'addressable/uri'

module Vindicia::Repository
  class Base
    DEFAULT_LIMIT = 100.freeze

    def self.first
      self.where({ limit: 1 }).first
    end

    def self.all
      self.where
    end

    def self.find(id)
      raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
      response = Vindicia::Request.new(:get, route(id)).response
      object = self.cast(response)
      Vindicia::Response::Object.new(object)
    end

    def self.where(query = {})
      Hashie.symbolize_keys!(query)

      max = query[:limit]
      query[:limit] = [(max || DEFAULT_LIMIT), DEFAULT_LIMIT].min

      Vindicia::Response::Collection.new(self._where(query, max))
    end

    private

    def self._where(query, max)
      response = Vindicia::Request.new(:get, route, { query: query }).response
      objects = self.cast(response)

      if (response['next'] && (max.nil? || objects.count < max))
        query = Hashie.symbolize_keys(Addressable::URI.parse(response['next']).query_values)
        query[:limit] = query[:limit].to_i

        if (max)
          max -= objects.count
          query[:limit] = max if max < query[:limit]
        end

        objects.concat(self._where(query, max))
      end

      objects
    end

    def self.route(id=nil)
      class_name = self.name.split('::').last.downcase
      plural_class_name = ActiveSupport::Inflector.pluralize(class_name)
      [ '', plural_class_name, id ].compact.join('/')
    end

    def self.cast(hash)
      case hash['object']
      when 'List'
        hash['data'].map {|d| cast(d) }
      else
        Vindicia::Model.const_get(hash['object']).new(hash)
      end
    end
  end
end
