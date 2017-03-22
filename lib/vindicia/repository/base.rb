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
      Vindicia::Response::Collection.new(self._where(query, query.delete(:limit)))
    end

    def self.save(model)
      Vindicia::Response::Object.new(Vindicia::Request.new(:post, route(model.vid), { body: model.to_json }))
    end

    private

    def self._where(query, max)
      query = Hashie::Mash.new(query)

      query.limit ||= DEFAULT_LIMIT
      query.limit = query.limit.to_i
      query.limit = max if max && max < query.limit

      response = Vindicia::Request.new(:get, route, { query: query }).response
      objects = self.cast(response)

      if (response.next && (max.nil? || objects.count < max))
        max -= objects.count if max
        query = Addressable::URI.parse(response.next).query_values
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
