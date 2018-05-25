require 'active_support/concern'

module Cashbox::Rest
  module ReadWrite
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def save
        save!
      rescue Exception
        false
      end

      def save!
        request = Cashbox::Request.new(:post, route(self.vid), { body: self.to_json })
        self.class.cast(self, request.response)
        true
      end
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
