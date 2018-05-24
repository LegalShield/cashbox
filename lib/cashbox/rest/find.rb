require 'active_support/concern'

module Cashbox::Rest
  module Find
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers
    end

    class_methods do
      def find(id)
        raise ArgumentError.new("Cannot find Resource with id 'nil'") unless id
        request = Cashbox::Request.new(:get, route(id))
        self.cast(self.new, request.response)
      end

      def first
        where({ limit: 1 }).first
      end

      def all
        where
      end

      def where(params = {})
        Hashie.symbolize_keys!(params)
        query(params, params.delete(:limit))
      end
    end
  end
end
