module Cashbox
  class Price < Model

    property :amount, coerce: Float
    property :currency
  end
end
