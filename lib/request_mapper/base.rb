module Vindicia::RequestMapper
  class Base
    delegate :object, { to: :'@model' }

    def initialize(model)
      @model = model
    end

    def as_json(options={})
      (self.public_methods - Object.methods).inject({}) do |memo, method_name|
        memo[method_name] = self.send(method_name)
        memo
      end
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def self._present(model)
      "Vindicia::RequestMapper::#{model.object}".constantize.new(model)
    end

    private

    def _present(*args)
      self.class._present(*args)
    end

  end
end
