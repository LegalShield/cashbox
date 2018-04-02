module Cashbox
  class Price < Model
    include Cashbox::Concern::Objectable

    property :amount, coerce: Float
    property :currency
  end
end
