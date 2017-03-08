module Vindicia::ResponseMapper
  class ProductPrice < Base
    def map
      attributes = @response.slice('currency')
      attributes['amount'] = @response['amount'].to_f if @response['amount']

      model_klass.new(attributes)
    end
  end
end
