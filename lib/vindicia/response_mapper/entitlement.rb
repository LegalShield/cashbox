module Vindicia::ResponseMapper
  class Entitlement < Base
    def map
      model_klass.new(@response.slice('id', 'decsription'))
    end
  end
end
