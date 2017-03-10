module Vindicia::Model
  class Price < Base
    property :amount, coerce: Float
    property :currency
  end
end
