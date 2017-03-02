module Vindicia::ResponseMapper
  class ProductPrice < Base
    def map(response)
      attributes = response.slice(:amount, :currency)
      attributes[:amount] = attributes[:amount].to_f if attributes[:amount]

      instance.update_attributes(attributes)
    end
  end
end
