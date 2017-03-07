module Vindicia::RequestMapper
  class Base
    extend Forwardable
    def_delegators :@instance, :object

    def initialize(instance)
      @instance = instance
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def self.map(instance)
      "Vindicia::RequestMapper::#{instance.object}".constantize.new(instance)
    end

    private

    def as_json(options={})
      (self.public_methods - Object.methods).inject({}) do |memo, method_name|
        memo[method_name] = self.send(method_name)
        memo
      end
    end

    #def _present(*args)
      #self.class._present(*args)
    #end
  end
end
