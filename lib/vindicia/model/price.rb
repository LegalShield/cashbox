module Vindicia::Model
  class Price < Base
    property :amount, coerce: BigDecimal
    property :currency
  end
end
