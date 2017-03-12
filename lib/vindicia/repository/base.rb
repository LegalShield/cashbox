require 'active_support/inflector'

module Vindicia::Repository
  class Base
    def self.where(query = {})
      Vindicia::Response::Collection.new(Vindicia::Request.new(:get, route, { query: { limit: 100 }.merge(query)}))
    end

    def self.first
      self.where({ limit: 1 }).first
    end

    def self.all
      self.where
    end

    def self.find(id)
      raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
      Vindicia::Response::Object.new(Vindicia::Request.new(:get, route(id)))
    end

    #def save(model)
      #Vindicia::Response.new(Vindicia::Request.new(:post, route(id), Vindicia::RequestMapper::Base.map(model)))
    #end

    private

    def self.route(id=nil)
      class_name = self.name.split('::').last.downcase
      plural_class_name = ActiveSupport::Inflector.pluralize(class_name)
      [ '', plural_class_name, id ].compact.join('/')
    end
  end
end
