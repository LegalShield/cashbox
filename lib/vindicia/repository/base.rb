require 'active_support/inflector'

module Vindicia::Repository
  class Base
    include HTTParty
    #debug_output $stderr
    format :json

    def where(query = {})
      map_response(get(route, { limit: 500 }.merge(query)))
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
      Vindicia::ResponseMapper::Base.map(response.to_h)
    end

    def get(path, query = {})
      self.class.get(path, { basic_auth: basic_auth, query: query })
    end

    def post(path, body)
      self.class.post(path, { basic_auth: basic_auth, body: body.to_json })
    end

    def basic_auth
      { username: Vindicia.username, password: Vindicia.password }
    end

    def route(id=nil)
      route_name = ActiveSupport::Inflector.pluralize(self.class.name.split('::').last.downcase)
      [ '', route_name, id ].compact.join('/')
    end
  end
end

require 'vindicia/repository/product'
