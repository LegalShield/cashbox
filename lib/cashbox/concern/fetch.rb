require 'active_support/concern'

module Cashbox::Concern
  module Fetch
    extend ActiveSupport::Concern

    included do
      extend Forwardable unless kind_of?(Forwardable)
      extend StaticRepository unless kind_of?(StaticRepository)

      def_single_delegators :repository, :where, :all, :first, :find
    end

    class_methods do
      def repository
        Cashbox::Repository.new(self.new)
      end
    end
  end
end
