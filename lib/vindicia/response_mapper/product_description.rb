module Vindicia::ResponseMapper
  class ProductDescription < Base
    def map
      model_klass.new(@response.slice('language', 'description'))
    end
  end
end
