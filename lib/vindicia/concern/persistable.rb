require 'active_support/concern'

module Vindicia::Concern
  module Persistable
    extend ActiveSupport::Concern

    included do
      extend Forwardable
      extend SingleForwardable

      def_single_delegators :criteria, :where, :all, :first, :find
      def_instance_delegator :repository, :save

      def repository
        @repository ||= Vindicia::Repository.new(self)
      end
    end

    class_methods do
      def criteria
        Vindicia::Criteria.new(self.new.repository)
      end
    end
  end
end
