module Cashbox
  class Price < Model
    include Concern::Objectable

    property :amount, coerce: Float
    property :currency
  end
end
