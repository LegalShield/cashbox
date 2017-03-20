require 'active_support/inflector'
require 'addressable/uri'

module Vindicia::Repository
  class Base
    DEFAULT_QUERY = { limit: 100 }.freeze

    def self.where(query = {})
      limit = query[:limit]
      query = DEFAULT_QUERY.merge(query)

      response = Vindicia::Request.new(:get, route, { query: query }).response
      limit = [(limit || response['total_count']), response['total_count']].min
      objects = self.cast(response.to_h)
      current_count = objects.size

      while ((next_page = response['next']) && current_count <= limit) do
        query = Addressable::URI.parse(next_page).query_values

        response = Vindicia::Request.new(:get, route, { query: query }).response
        objects = objects.concat(self.cast(response.to_h))
        current_count += objects.size
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
      when 'Error'
        Vindicia::Exception.new(@response.to_h)
      when 'List'
        hash['data'].map {|d| cast(d) }
      else
        Vindicia::Model.const_get(hash['object']).new(hash)
      end
    end

    def perform

    end
  end
end
