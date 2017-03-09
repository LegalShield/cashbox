module Vindicia::Model
  class ProductPrice < Base
    property :amount, coerce: Float
    property :currency
  end
end
