require 'active_support/concern'

module Cashbox::Rest
  module Save
    extend ActiveSupport::Concern

    included do
      extend Forwardable

      def_instance_delegators :repository, :save, :save!

      def repository
        Cashbox::Repository.new(self)
      end
    end
  end
end
