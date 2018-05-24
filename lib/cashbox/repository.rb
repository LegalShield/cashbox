require 'active_support/inflector'
require 'addressable/uri'

module Cashbox
  class Repository

    attr_reader :instance

    def initialize(instance)
      @instance = instance
    end

  end
end
