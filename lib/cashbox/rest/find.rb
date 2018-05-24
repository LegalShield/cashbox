require 'active_support/concern'

module Cashbox::Rest
  module Find
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers
    end

    class_methods do
      def first
        where({ limit: 1 }).first
      end

      def all
        where
      end

      def find(id)
        raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
        self.cast(self.new, Cashbox::Request.new(:get, route(id)).response)
      end

      def where(params = {})
        Hashie.symbolize_keys!(params)
        query(params, params.delete(:limit))
      end
    end
  end
end
