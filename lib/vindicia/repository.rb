require 'active_support/inflector'
require 'addressable/uri'

module Vindicia
  class Repository
    DEFAULT_LIMIT = 100.freeze

    def initialize(instance)
      @instance = instance
    end

    def first
      where({ limit: 1 }).first
    end

    def all
      where
    end

    def find(id)
      raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
      cast(Vindicia::Request.new(:get, route(id)).response)
    end

    def where(query = {})
      Hashie.symbolize_keys!(query)
      _where(query, query.delete(:limit))
    end

    def save
      request = Vindicia::Request.new(:post, route(@instance.vid), { body: @instance.to_json })
      cast(request.response)
    end

    private

    def _where(query, max)
      query = Hashie::Mash.new(query)

      query.limit ||= DEFAULT_LIMIT
      query.limit = query.limit.to_i
      query.limit = max if max && max < query.limit

      response = Vindicia::Request.new(:get, route, { query: query }).response
      objects = cast(response)

      if (response.next && (max.nil? || objects.count < max))
        max -= objects.count if max
        query = Addressable::URI.parse(response.next).query_values
        objects.concat(_where(query, max))
      end

      objects
    end

    def route(id=nil)
      class_name = @instance.class.name.split('::').last.downcase
      plural_class_name = ActiveSupport::Inflector.pluralize(class_name)
      [ '', plural_class_name, id ].compact.join('/')
    end

    def cast(hash)
      case hash['object']
      when 'List'
        hash['data'].map do |data|
          @instance.class.new(data)
        end
      else
        @instance.deep_merge!(hash)
      end
    end
  end
end
