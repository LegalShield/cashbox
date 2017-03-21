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
      max = query.delete(:limit)
      limit = [ ( max || DEFAULT_LIMIT ), DEFAULT_LIMIT ].min
      query = { limit: limit }.merge(query)
      objects = self._where(query, max)
      Vindicia::Response::Collection.new(objects)
    end

    private

    def self._where(query, max)
      response = Vindicia::Request.new(:get, route, { query: query }).response
      objects = self.cast(response)

      if (response['next'] && (max.nil? || objects.count < max))
        query = Hashie.symbolize_keys(Addressable::URI.parse(response['next']).query_values)
        if (max)
          max -= objects.count
          limit = [max, query[:limit].to_i].min
          query = query.merge({ limit: limit })
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
