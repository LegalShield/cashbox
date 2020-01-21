module Cashbox
  class Price < Model
    include Concern::Objectable

    property :amount, coerce: Vindicia::Type.BigDecimal
    property :currency
  end
end
