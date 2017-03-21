require 'active_support/inflector'
require 'addressable/uri'

module Vindicia::Repository
  class Base
    DEFAULT_LIMIT = 100.freeze

    def self.where(query = {})
      objects = []

      max = query.delete(:limit)
      limit = [ ( max || DEFAULT_LIMIT ), DEFAULT_LIMIT ].min
      query = { limit: limit }.merge(query)

      begin
        response = Vindicia::Request.new(:get, route, { query: query }).response
        objects.concat(self.cast(response))
      end while begin
        if (response['next'] && (max.nil? || objects.count < max))
          query = Addressable::URI.parse(response['next']).query_values
        end
      end

      Vindicia::Response::Collection.new(objects)
    end

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

    private

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
