require 'active_support/concern'

module Vindicia::Concern
  module Persistable
    extend ActiveSupport::Concern

    included do
      extend Forwardable
      extend SingleForwardable

      def_single_delegators :repository, :where, :all, :first
      def_instance_delegator :repository, :save

      def repository
        Vindicia::Repository.new(self)
      end
    end

    class_methods do
      def repository
        Vindicia::Repository.new(self.new)
      end
    end
  end
end
