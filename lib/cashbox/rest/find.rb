require 'active_support/concern'

module Cashbox::Rest
  module Find
    extend ActiveSupport::Concern

    included do
      extend SingleForwardable

      def_single_delegators :repository, :find, :where, :first
    end

    class_methods do
      def repository
        Cashbox::Repository.new(self.new)
      end
    end
  end
end

#require 'active_support/concern'

#module Cashbox::Concern
  #module Persistable
    #extend ActiveSupport::Concern

    #included do
      #extend Forwardable
      #extend SingleForwardable

      #def_single_delegators :repository, :where, :all, :first, :find
      #def_instance_delegators :repository, :save, :save!, :destroy

      #def repository
        #@repository ||= Cashbox::Repository.new(self)
      #end
    #end

    #class_methods do
      #def repository
        #Cashbox::Repository.new(self.new)
      #end
    #end
  #end
#end
