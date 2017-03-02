module Vindicia::Concern
  module Persistable

    def self.included(base)
      base.extend(ClassMethods)
      base.include(InstanceMethods)
    end

    module ClassMethods
      def find(*args)
        repository.find(*args)
      end

      def where(*args)
        repository.where(*args)
      end

      def all(*args)
        repository.all(*args)
      end

      def first
        repository.first
      end

      def repository
        "Vindicia::Repository::#{self.name.split('::').last}".constantize.new
      end
    end

    module InstanceMethods
      def save
        repository.save(self)
      end

      def repository
        @repository ||= self.class.repository
      end
    end
  end
end
