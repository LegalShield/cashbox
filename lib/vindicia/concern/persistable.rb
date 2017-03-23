require 'active_support/concern'

module Vindicia::Concern
  module Persistable
    extend ActiveSupport::Concern

    included do
      def save
        repository.save
      end

      private

      def repository
        Vindicia::Repository.new(self)
      end
    end

    class_methods do
      def all
        repository.all
      end

      def where(*args)
        repository.where(*args)
      end

      def first(*args)
        repository.first
      end

      private

      def repository
        Vindicia::Repository.new(self.new)
      end
    end
  end
end
