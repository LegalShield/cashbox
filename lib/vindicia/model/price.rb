module Vindicia
  class Price < Model
    include Vindicia::Concern::Objectable

    property :amount, coerce: Vindicia::Type.BigDecimal
    property :currency
  end
end
