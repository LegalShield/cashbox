module Vindicia
  class Price < Model
    include Vindicia::Concern::Objectable

    property :amount, coerce: BigDecimal
    property :currency
  end
end
