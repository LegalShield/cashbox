require 'active_support/concern'

module Cashbox::Concern
  module Persistable
    extend ActiveSupport::Concern

    included do
      extend Forwardable
      extend SingleForwardable

      def_single_delegators :repository, :where, :all, :first, :find
      def_instance_delegator :repository, :save

      def repository
        @repository ||= Cashbox::Repository.new(self)
      end
    end

    class_methods do
      def repository
        Cashbox::Repository.new(self.new)
      end
    end
  end
end
