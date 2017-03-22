module Vindicia
  class Price < Model
    include Vindicia::Concern::Objectable

    property :amount, coerce: Float
    property :currency
  end
end
