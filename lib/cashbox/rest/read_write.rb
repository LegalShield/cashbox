require 'active_support/concern'
require 'pry-byebug'

module Cashbox::Rest
  module ReadWrite
    extend ActiveSupport::Concern

    DEFAULT_LIMIT = 100.freeze

    included do
      include Cashbox::Rest::Helpers

      def save
        save!
      rescue Exception
        false
      end

      def save!
        binding.pry
        request = Cashbox::Request.new(:post, route(self.vid), { body: self.to_json })
        self.class.cast(self, request.response)
        true
      end
    end

    class_methods do
      def find(id)
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

      private

      def query(params, max)
        params = Hashie::Mash.new(params)

        params.limit ||= DEFAULT_LIMIT
        params.limit = params.limit.to_i
        params.limit = max if max && max < params.limit

        response = Cashbox::Request.new(:get, route, { query: params }).response
        objects = cast(self.new, response)

        if (response.next && (max.nil? || objects.count < max))
          max -= objects.count if max
          params = Addressable::URI.parse(response.next).query_values
          objects.concat(query(params, max))
        end

        objects
      end
    end
  end
end
