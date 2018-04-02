module Cashbox
  class Price < Model
    include Cashbox::Concern::Objectable

    property :amount, coerce: Vindicia::Type.BigDecimal
    property :currency
  end
end
